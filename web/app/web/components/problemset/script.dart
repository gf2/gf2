import 'dart:html';
import 'package:web_ui/web_ui.dart';

class ProblemSetComponent extends WebComponent {
  //TODO(Nicholas): Add logic here.
  List<Element> sectionElements;
  int currentSection = 0;
  
  ProblemSetComponent() {
  }
  
  void created() {
    print("component created.");
    SpanElement nextSection = this._root.query('#problemset-next-section');
    nextSection.onClick.listen((event) => nextSection());
  }
  
  void insterted() {
    sectionElements = this._host.query('#problem-set-container').children;
    print("component instered.");
  }
  
  void nextSection() {
    sectionElements= this._host.query('#problem-set-container').children;
    sectionElements.elementAt(currentSection).hidden = true;
    currentSection += 1;
    sectionElements.elementAt(currentSection).hidden = false;
  }
  
}