import 'dart:html';
import 'package:web_ui/web_ui.dart';

class LoginComponent extends WebComponent {
  int count = 0;
  ButtonElement submitButton = document.query("#login-submit");
  

  onLoginClick(MouseEvent event) {
    count += 1;
    document.query('#login-message').text = "Hello World" + count.toString();
  }
}

