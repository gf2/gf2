library models_test;
import 'dart:async';
import 'package:unittest/unittest.dart';

import 'package:app/models.dart';
import 'package:app/requests.dart';

void main() {
  new Timer(new Duration(seconds:1), () => startTest());
}

void startTest() {
  GetSectionRequest request = new GetSectionRequest(
      "1234", url:"/app/fakedata/reading_section.json");
  request.getSection()
      .then((AbstractSection section) => print(section.jsonContent));
}