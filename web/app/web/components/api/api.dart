library api;

import 'dart:async';
import 'dart:html';
import 'dart:json';

part 'user.dart';

class BaseApi {
  static Future<String> get(url) {
    // Stub API calls here.
    // return new Future.of(() => '{"available":true}');
    return HttpRequest.getString(url);
  }
}

class BaseJsonApi extends BaseApi {
  static Future<Map> get(url) {
    return BaseApi.get(url).then((response) => parse(response));
  }
}

