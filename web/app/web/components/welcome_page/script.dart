import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class WelcomePage extends WebComponent {
  DivElement signupDiv = null;
  Element signupBtn = null;
  Element loginBtn = null;
  
  void created() {
    signupDiv = this._root.query("#gf2-signup");
    signupDiv.hidden = true;
    signupDiv.onClick.listen((event) {
      if (event.target == signupDiv) {
        signupDiv.hidden = true;
      }
    });
    
    signupBtn = this._root.query("#signup-btn");
    signupBtn.onClick.listen((event) {
      signupDiv.hidden = false;
    });
    
    loginBtn = this._root.query("#login-btn");
    
    document.onKeyDown.listen(documentKeydown);
  }
  
  documentKeydown(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ESC) {
      signupDiv.hidden = true;
    }
  }
}
