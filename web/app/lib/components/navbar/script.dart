
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class NavbarComponent extends WebComponent {
  void onLoginClick(MouseEvent event) {
  }
  
  void created() {
    DivElement loginForm = this._root.query("#login-form");
    DivElement userPanel = this._root.query("#user-panel");
    var user = UserManager.getUser();
    if (user != null) {
      loginForm.hidden = true;
    } else {
      userPanel.hidden = true;
    }
  }
  
  void onLogoutClick(MouseEvent event) {
    UserManager.logout();
  }
}