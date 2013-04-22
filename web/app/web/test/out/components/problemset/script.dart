// Auto-generated from template.html.
// DO NOT EDIT.

library gf2_problem_set;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'dart:html';
import 'package:web_ui/web_ui.dart';



/**
 *  This component manages all sections.
 */
class ProblemSetComponent extends WebComponent {
  /** Autogenerated from the template. */

  /** CSS class constants. */
  static Map<String, String> _css = {};

  /**
   * Shadow root for this component. We use 'var' to allow simulating shadow DOM
   * on browsers that don't support this feature.
   */
  var _root;
  static final __shadowTemplate = new autogenerated.DocumentFragment.html('''
        <div>
           <span id="problemset-previous-section">Previous Section</span>
           <span id="problemset-next-section">Next Section</span>
        </div>
        <div id="problemset-container">
          <content>
          </content>
        </div>
      ''');
  autogenerated.Template __t;

  void created_autogenerated() {
    _root = createShadowRoot();
    __t = new autogenerated.Template(_root);
    _root.nodes.add(__shadowTemplate.clone(true));
    __t.create();
  }

  void inserted_autogenerated() {
    __t.insert();
  }

  void removed_autogenerated() {
    __t.remove();
    __t = null;
  }

  void composeChildren() {
    super.composeChildren();
    if (_root is! autogenerated.ShadowRoot) _root = this;
  }

  /** Original code from the component. */

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
//@ sourceMappingURL=script.dart.map