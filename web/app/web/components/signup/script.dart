import '../api/api.dart';

import 'dart:html';
import 'package:web_ui/web_ui.dart';

class SignupComponent extends WebComponent {

  validateEmailHandler(isValid) {
    document.query('#signup-message').text = isValid ? "YES" : "NO";
  }
  
  onSignupClick(MouseEvent event) {
     document.query('#signup-message').text = "Thanks for signup";
  }
  
  onEmailChange(Event event) {
    InputElement emailInput = document.query('#signup-email');
    String email = emailInput.value;
    new EmailChecker(email).check(validateEmailHandler);
  }
}
