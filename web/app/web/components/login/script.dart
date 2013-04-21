import 'package:app/gf2lib.dart';

import 'dart:async';
import 'dart:html';
import 'package:web_ui/web_ui.dart';

class LoginComponent extends WebComponent {
  Element errMsg = null;
  DivElement emailGroup = null;
  DivElement passwordGroup = null;
  InputElement loginEmail = null;
  InputElement loginPassword = null;
  ImageElement waiting = null;
  ImageElement success = null;
  
  void created() {
    errMsg = this._root.query("#errmsg");
    errMsg.hidden = true;
    
    emailGroup = this._root.query("#email-group");
    passwordGroup = this._root.query("#password-group");
    
    loginEmail = this._root.query("#login-email");
    loginPassword = this._root.query("#login-password");
      
    waiting = this._root.query("#waiting");
    waiting.hidden = true;
    success = this._root.query("#success");
    success.hidden = true;
    
    loginPassword.onKeyDown.listen(handleKeydown);
    loginEmail.onKeyDown.listen(handleKeydown);
  }
  
  handleKeydown(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ENTER) {
      login();
    }
  }
  
  handleLoginResult(result) {
    waiting.hidden = true;
    if (result == "SUCCESS") {
      success.hidden = false;
      new Timer(new Duration(seconds: 1), () {
        window.location.href = "/";
      });
      
    } else if (result == "FAILURE") {
      errMsg.hidden = false;
      errMsg.text = Messages.get("LOGIN_FAILURE_MSG");  
      emailGroup.classes.add("error");
      passwordGroup.classes.add("error");
      
    } else {
      // Something is wrong.
    }
  }
  
  login() {
    waiting.hidden = false;
    UserManager.login(
        loginEmail.value,
        loginPassword.value).then(handleLoginResult);
  }
  
  onLoginClick(MouseEvent event) {
     login();
  }
}
