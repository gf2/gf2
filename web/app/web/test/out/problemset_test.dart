// Auto-generated from problemset_test.html.
// DO NOT EDIT.

library problemset_test;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import '_from_packages/app/components/problemset/script.dart';
import '_from_packages/app/components/section_reading/script.dart';
import '_from_packages/app/components/section_listening/script.dart';
import '_from_packages/app/components/section_speaking/script.dart';
import '_from_packages/app/components/section_writing/script.dart';
import 'dart:async';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:unittest/unittest.dart';


// Original code

// TODO(Nicholas Zhao): Try to move all test to on directory.
// TODO(Nicholas Zhao): Run test in command line.   
void main() {
  new Timer(new Duration(seconds:2), () => startTest());
}

void startTest() {
  expect(document.query("#problemset-container").children.length, 4);
  SpanElement previousSectionButton = query('#problemset-previous-section');
  SpanElement nextSectionButton = query("#problemset-next-section");
  expect(previousSectionButton.hidden, true);
  for (int i = 0; i < 3; i++) {
    nextSectionButton.click();
  }
  expect(previousSectionButton.hidden, false);
  expect(nextSectionButton.hidden, true);
  document.body.innerHtml = '<span style="color: green">Test passed!!!</span>';
}


// Additional generated code
void init_autogenerated() {
  var _root = autogenerated.document.body;
  var __e0, __e1, __e2, __e3, __e4;
  var __t = new autogenerated.Template(_root);
  __e4 = _root.nodes[1].nodes[1];
  __e0 = __e4.nodes[1];
  __t.component(new ReadingSectionComponent()..host = __e0);
  __e1 = __e4.nodes[3];
  __t.component(new ListeningSectionComponent()..host = __e1);
  __e2 = __e4.nodes[5];
  __t.component(new SpeakingSectionComponent()..host = __e2);
  __e3 = __e4.nodes[7];
  __t.component(new WritingSectionComponent()..host = __e3);
  __t.component(new ProblemSetComponent()..host = __e4);
  __t.create();
  __t.insert();
}

//@ sourceMappingURL=problemset_test.dart.map