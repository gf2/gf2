library api;

import 'dart:async';
import 'dart:html';
import 'dart:json';

class BaseApi {
  static Future<String> get(url) {
    return new Future.of(() => '{"available":true}'); // Stub API calls here.
    return HttpRequest.getString(url);
  }
}

class BaseJsonApi extends BaseApi {
  static Future<Map> get(url) {
    return BaseApi.get(url).then((response) => parse(response));
  }
}

