import 'dart:io';
import 'package:web_ui/component_build.dart';

// Ref: http://www.dartlang.org/articles/dart-web-components/tools.html
main() {
  Options option = new Options();
  print(option.arguments);
  build(new Options().arguments, [
      'web/app.html',
      'web/problemset_test.html',
      ]);
}
