
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class NavbarComponent extends WebComponent {
  void onLoginClick(MouseEvent event) {
  }
  
  void created() {
    var user = UserManager.getUser();
    if (user == null) {
      window.location.href = '/';
    }
  }
  
  void onLogoutClick(MouseEvent event) {
    UserManager.logout();
  }
}