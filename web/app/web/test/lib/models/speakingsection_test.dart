library readingsection_test;
import 'package:unittest/unittest.dart';
import 'package:app/requests.dart';

import 'package:app/models.dart';


int testSpeakingSection() {
  GetSectionRequest request = new GetSectionRequest(
      "1234", url:"/app/fakedata/speaking_section.json");
  request.getSection().then((SpeakingSection speakingSection) => print(speakingSection.type));
  return 1;
}

main() {
  testSpeakingSection();
}
