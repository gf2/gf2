
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class NavbarComponent extends WebComponent {
  Element testTab = null;
  Element practiceTab = null;
  
  void onLoginClick(MouseEvent event) {
  }
  
  void created() {
    testTab = this._root.query("#test-tab");
    practiceTab = this._root.query("#practice-tab");
    window.onHashChange.listen(handleHashChange);
  }
  
  void onLogoutClick(MouseEvent event) {
    UserManager.logout();
  }
  
  handleHashChange(Event e) {
    if (window.location.hash == '#test') {
      testTab.classes.add("active");
      practiceTab.classes.remove("active");
    } else if (window.location.hash == '#practice') {
      testTab.classes.remove("active");
      practiceTab.classes.add("active");
    } else if (window.location.hash == '#select-cn') {
      Messages.setLanguage('ch');
    } else if (window.location.hash == '#select-en') {
      Messages.setLanguage('en');
    } else if (window.location.hash == '#') {
      // ignore.
    }
  }
}