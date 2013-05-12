library browser_test;
import 'dart:async';
import 'dart:html';
import 'package:unittest/unittest.dart';
import 'lib/models/readingsection_test.dart';

void main() {
  test("Construction", () => expect(create(), 1));
  test("Construction", () => expect(create(), 2));
  print("unittest-suite-done");
  query("body").innerHtml = "pass";
}
