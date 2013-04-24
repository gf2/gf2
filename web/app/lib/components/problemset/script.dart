import 'dart:html';
import 'package:web_ui/web_ui.dart';

part of "gf2components";

/**
 *  This component manages all sections.
 */
class ProblemSetComponent extends WebComponent {
  // All sections.
  List<Element> sections;
  // The nav button to next section.
  Element previousSectionButton;
  // The nav button to previous section.
  Element nextSectionButton;
  int currentSection = 0;
  
  void created() {
    print("component created.");
    // This warning is a unfixed issue in dart.
    // See http://www.dartlang.org/articles/web-ui/spec.html#lifecycle-methods
    nextSectionButton = this._root.query('#problemset-next-section');
    nextSectionButton.onClick
        .listen((event) => this.nextSection(event));
    previousSectionButton= this._root.query("#problemset-previous-section");
    previousSectionButton.onClick
        .listen((event) => this.previousSection(event));
  }
  
  void inserted() {
    sections= this._root.query('#problemset-container').children;
    for (int i = 0; i < sections.length; i++) {
      sections.elementAt(i).hidden = i != currentSection;
    }
    updateNavStatus();
  }
  
  void nextSection(MouseEvent event) {
    sections.elementAt(currentSection).hidden = true;
    currentSection += 1;
    sections.elementAt(currentSection).hidden = false;
    updateNavStatus();
  }
  
  void previousSection(MouseEvent event) {
    sections.elementAt(currentSection).hidden = true;
    currentSection -= 1;
    sections.elementAt(currentSection).hidden = false;
    updateNavStatus();
  }
  
  void updateNavStatus() {
    if (currentSection == sections.length -1) {
      nextSectionButton.hidden = true;
    } else {
      nextSectionButton.hidden = false;
    }
    
    if (currentSection == 0) {
      previousSectionButton.hidden = true;
    } else {
      previousSectionButton.hidden = false;
    }
  }
}