import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';

class HomePage extends WebComponent {
 
  void created() {
    var user = UserManager.getUser();
    if (user == null) {
      window.location.href = '/';
    }
    window.onHashChange.listen(handleHashChange);
  }
  
  handleHashChange(Event e) {
    
  }
}


