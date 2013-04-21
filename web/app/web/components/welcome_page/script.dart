import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class WelcomePage extends WebComponent {
  DivElement signupDiv = null;
  DivElement loginDiv = null;
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
    
    loginDiv = this._root.query("#gf2-login");
    loginDiv.hidden = true;
    loginDiv.onClick.listen((event) {
      if (event.target == loginDiv) {
        loginDiv.hidden = true;
      }
    });
    
    loginBtn = this._root.query("#login-btn");
    loginBtn.onClick.listen((event) {
      loginDiv.hidden = false;
    });
    
    document.onKeyDown.listen(documentKeydown);
  }
  
  documentKeydown(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ESC) {
      signupDiv.hidden = true;
      loginDiv.hidden = true;
    }
  }
}
