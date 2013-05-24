library listeningsection_test;
import 'package:unittest/unittest.dart';
import 'package:app/requests.dart';

import 'package:app/models.dart';


int testListeingSection() {
  GetSectionRequest request = new GetSectionRequest(
      "1234", url:"/app/fakedata/listening_section.json");
  request.getSection().then((ListeningSection listeningSection) => print(listeningSection.audio));
  return 1;
}

main() {
  testListeingSection();
}
