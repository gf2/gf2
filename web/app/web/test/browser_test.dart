library browser_test;
import 'package:unittest/html_enhanced_config.dart';
import 'dart:async';
import 'dart:html';
import 'package:unittest/unittest.dart';
import 'lib/models/readingsection_test.dart';
import 'lib/models/listeningsection_test.dart';
import 'lib/models/speakingsection_test.dart';
import 'lib/models/writingsection_test.dart';

void main() {
  useHtmlEnhancedConfiguration();
  test("testReadingSection", () => expect(testReadingSection(), 1));
  test("testListeingSection", () => expect(testListeingSection(), 1));
  test("testSpeakingSection", () => expect(testSpeakingSection(), 1));
  test("testWritingSection", () => expect(testWritingSection(), 1));
}
