library models_test;
import 'package:unittest/unittest.dart';

import 'package:app/models.dart';
import 'package:app/requests.dart';

void main() {
  GetSectionRequest request = new GetSectionRequest("1234");
  request.getSection();
}