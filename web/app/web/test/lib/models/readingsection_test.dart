library readingsection_test;
import 'package:unittest/unittest.dart';
import 'package:app/requests.dart';

import 'package:app/models.dart';


int testReadingSection() {
  GetSectionRequest request = new GetSectionRequest(
      "1234", url:"/app/fakedata/reading_section.json");
  request.getSection().then((ReadingSection readingSection) => verifyReadingSection(readingSection));
  return 1;
}

void verifyReadingSection(ReadingSection readingSection) {
  expect(readingSection.questions.length, 1);
  MultiChoiceQuestion multiChoiceQuestion = readingSection.questions[0];
  print(multiChoiceQuestion);
  expect(multiChoiceQuestion.answer, 0);
}

main() {
  testReadingSection();
}
