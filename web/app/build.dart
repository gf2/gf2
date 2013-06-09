import 'dart:io';
import 'package:web_ui/component_build.dart';

main() {
  Options option = new Options();
  print(option.arguments);
  build(new Options().arguments, [
      'web/app.html',
      'web/welcome.html',
      'web/test/problemset_test.html',
      'web/test/readingsection_test.html',
      "web/test/browser_test.html",
      ]);
}
