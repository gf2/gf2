import 'package:app/gf2lib.dart';

import 'dart:async';
import 'dart:html';
import 'package:web_ui/web_ui.dart';

class SignupComponent extends WebComponent {
  Element errMsgPassword = null;
  Element errMsgPasswordRep = null;
  Element errMsgEmail = null;
  DivElement emailGroup = null;
  DivElement passwordGroup = null;
  DivElement passwordRepGroup = null;
  InputElement signupEmail = null;
  InputElement signupNickname = null;
  InputElement signupPassword = null;
  InputElement signupPasswordRep = null;
  ImageElement waiting = null;
  ImageElement success = null;
  
  void created() {
    errMsgEmail = this._root.query("#errmsg-email");
    errMsgEmail.hidden = true;
    errMsgPassword = this._root.query("#errmsg-password");
    errMsgPassword.hidden = true;
    errMsgPasswordRep = this._root.query("#errmsg-password-rep");
    errMsgPasswordRep.hidden = true;
    
    emailGroup = this._root.query("#email-group");
    passwordGroup = this._root.query("#password-group");
    passwordRepGroup = this._root.query("#password-rep-group");
    
    
    signupEmail = this._root.query("#signup-email");
    signupNickname = this._root.query("#signup-nickname");
    signupPassword = this._root.query("#signup-password");
    signupPassword.onBlur.listen((e) {
      if (signupPassword.value.length < 6) {
        passwordErr(Messages.get('PASSWORD_TOO_SHORT'));
      } else {
        errMsgPassword.hidden = true;
        passwordGroup.classes.remove('error');
        passwordGroup.classes.add('success');
      }
    });
    
    signupPasswordRep = this._root.query("#signup-password-rep");
    signupPasswordRep.onBlur.listen((e) {
      if (signupPasswordRep.value != signupPassword.value) {
        errMsgPasswordRep.text = Messages.get('PASSWORD_MOT_MATCH');
        errMsgPasswordRep.hidden = false;
        passwordRepGroup.classes.add('error');
        passwordRepGroup.classes.remove('success');
      } else {
        errMsgPasswordRep.hidden = true;
        passwordRepGroup.classes.remove('error');
        passwordRepGroup.classes.add('success');
      }
    });
    
    waiting = this._root.query("#waiting");
    waiting.hidden = true;
    success = this._root.query("#success");
    success.hidden = true;
  }
  
  validateEmailHandler(errMsg) {
    if (errMsg != null) {
      emailErr(errMsg);
    } else {
      emailGroup.classes.remove('error');
      emailGroup.classes.add('success');
      errMsgEmail.hidden = true;
    }
  }
  
  emailErr(errMsg) {
    errMsgEmail.text = errMsg;
    errMsgEmail.hidden = false;
    emailGroup.classes.add('error');
    emailGroup.classes.remove('success');
  }
  
  passwordErr(msg) {
    errMsgPassword.text = Messages.get('PASSWORD_TOO_SHORT');
    errMsgPassword.hidden = false;
    passwordGroup.classes.add('error');
    passwordGroup.classes.remove('success');
  }
  
  signupResultHandler(result) {
    waiting.hidden = true;
    if (result == "EMAIL_USED") {
      emailErr(Messages.get("EMAIL_TAKEN"));
    } else if (result == "INVALID_EMAIL") {
      emailErr(Messages.get("EMAIL_INVALID"));
    } else if (result == "INVALID_PASSWORD") {
      passwordErr(Messages.get('PASSWORD_TOO_SHORT'));
    } else if (result == "SUCCESS") {
      success.hidden = false;
      new Timer(new Duration(seconds: 1), () {
        window.location.href = "/";
      });
    } else {
      // Something is wrong.
    }
  }
  
  onSignupClick(MouseEvent event) {
     waiting.hidden = false;
     UserManager.signup(
         signupEmail.value,
         signupNickname.value,
         signupPassword.value).then(signupResultHandler);
  }
  
  onEmailChange(Event event) {
    String email = signupEmail.value;
    new EmailChecker(email).check().then(validateEmailHandler);
  }
}
