library user_api;

import 'dart:async';
import 'base.dart';

class UserApi extends BaseJsonApi {
  static checkEmail(email) {
    return BaseJsonApi.get('/a/check_email?email=' + email).then(
        (response) => response["available"]);
  }
}
