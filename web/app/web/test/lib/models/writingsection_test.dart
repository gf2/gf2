library writingsection_test;
import 'package:unittest/unittest.dart';
import 'package:app/requests.dart';

import 'package:app/models.dart';


int testWritingSection() {
  GetSectionRequest request = new GetSectionRequest(
      "1234", url:"/app/fakedata/writing_section.json");
  request.getSection().then((WritingSection writingSection) => print(writingSection.type));
  return 1;
}

main() {
  testWritingSection();
}
