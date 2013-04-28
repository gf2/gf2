import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/gf2lib.dart';
import 'package:app/models.dart';

part of "gf2components";

class ProblemsetRowComponent extends WebComponent {
 
  ImageElement icon;
  Element title;
  ProblemsetItem problemset;
  
  void created() {
  }
  
  void inserted() {
    title =  this._root.query('#title');
    title.text = this.problemset.name;
    icon = this._root.query('#status-icon');
    if (problemset.is_free) {
      icon.src = '/static/img/free.png';
    } else if(problemset.has_paid) {
      icon.src = '/static/img/unlocked.png';
    } else {
      icon.src = '/static/img/locked.png';
    }
  }
}
