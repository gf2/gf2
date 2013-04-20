import 'dart:async';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:unittest/unittest.dart';
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

