library readingsection_test;
import 'package:unittest/unittest.dart';
import 'package:app/requests.dart';

import 'package:app/models.dart';


int testReadingSection() {
  GetSectionRequest request = new GetSectionRequest(
      "1234", url:"/app/fakedata/reading_section.json");
  request.getSection().then((ReadingSection readingSection) => print(readingSection.title));
  return 1;
}

main() {
  testReadingSection();
}
