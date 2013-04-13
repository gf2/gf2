
import 'dart:html';
import 'package:web_ui/web_ui.dart';

import '../api/user.dart';

class SignupComponent extends WebComponent {
  RegExp emailExp = new RegExp(r"[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}");

  validateEmail(address) {
    if (!emailExp.hasMatch(address)) {
      validateEmailHandler(false);
      return;
    }
    UserApi.checkEmail(address).then(validateEmailHandler);
  }

  validateEmailHandler(isValid) {
    document.query('#signup-message').text = isValid ? "YES" : "NO";
  }
  
  onSignupClick(MouseEvent event) {
     document.query('#signup-message').text = "Thanks for signup";
  }
  
  onEmailChange(Event event) {
    InputElement emailInput = document.query('#signup-email');
    String email = emailInput.value;
    validateEmail(email);
  }
}


