import 'package:app/gf2lib.dart';

import 'dart:html';
import 'package:web_ui/web_ui.dart';

class SignupComponent extends WebComponent {

  validateEmailHandler(isValid) {
    document.query('#signup-message').text = isValid ? "YES" : "NO";
  }
  
  signupResultHandler(result) {
    document.query('#signup-message').text = result;
  }
  
  onSignupClick(MouseEvent event) {
     document.query('#signup-message').text = "Thanks for signup";
     UserManager.signup(
         document.query('#signup-email').value,
         document.query('#signup-nickname').value,
         document.query('#signup-password').value).then(signupResultHandler);
  }
  
  onEmailChange(Event event) {
    InputElement emailInput = document.query('#signup-email');
    String email = emailInput.value;
    new EmailChecker(email).check().then(validateEmailHandler);
  }
}
