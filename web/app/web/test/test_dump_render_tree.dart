library test_dump_render_tree;

import 'dart:async';
import 'dart:io';
import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

main() {
  testCore(new VMConfiguration());
}

void testCore(Configuration config) {
  unittestConfiguration = config;
  groupSep = ' - ';
  final browserTests = ['web/app/web/test/browser_test.html'];

  group('DumpRenderTree', () {
    browserTests.forEach((file) {
      test(file, () => _runDrt(file));
    });
  });
}

Future _runDrt(String htmlFile) {
  final allPassedRegExp = new RegExp('All \\d+ tests passed');

  return Process.run('DumpRenderTree', [htmlFile])
    .then((ProcessResult pr) {
      expect(pr.exitCode, 0, reason: 'DumpRenderTree should return exit code 0 - success');

      if(!allPassedRegExp.hasMatch(pr.stdout)) {
        print(pr.stdout);
        fail('Could not find success value in stdout: ${allPassedRegExp.pattern}');
      }
    });
}