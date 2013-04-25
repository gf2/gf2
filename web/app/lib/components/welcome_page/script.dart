import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class WelcomePage extends WebComponent {
  DivElement signupDiv = null;
  DivElement loginDiv = null;
  
  void created() {
    signupDiv = this._root.query("#gf2-signup");
    signupDiv.hidden = true;
    signupDiv.onClick.listen((event) {
      if (event.target == signupDiv) {
        window.location.hash = '#';
      }
    });
        
    loginDiv = this._root.query("#gf2-login");
    loginDiv.hidden = true;
    loginDiv.onClick.listen((event) {
      if (event.target == loginDiv) {
        window.location.hash = '#';
      }
    });
    
    document.onKeyDown.listen(handleKeydown);
    window.onHashChange.listen(handleHashChange);
  }
  
  handleKeydown(KeyboardEvent e) {
    if (e.keyCode == KeyCode.ESC) {
      signupDiv.hidden = true;
      loginDiv.hidden = true;
      window.location.hash = '#';
    }
  }
  
  handleHashChange(Event e) {
    loginDiv.hidden = true;
    signupDiv.hidden = true;
    if (window.location.hash == '#login') {
      loginDiv.hidden = false;
    } else if (window.location.hash == '#signup') {
      signupDiv.hidden = false;
    }
  }
}
