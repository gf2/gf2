library api;

import 'dart:async';
import 'dart:html';
import 'dart:json';

part 'user.dart';

class UrlBuilder {
  String url = null;
  Map data = null;
  
  UrlBuilder(url, [data = null]) {
    this.url = url;
    this.data = data;
  }
  
  get() {
    if (this.data != null) {
      if (this.url.contains("?")) {
        this.url += "&";
      } else {
        this.url += "?";
      }
      this.url += mapToString(this.data);
    }
    return this.url;
  }
  
  static mapToString(Map map) {
    if (map == null) {
      return '';
    }
    var res = '';
    map.forEach((key, value) {
      if (res.length > 0) {
        res += "&";
      }
      res += key + "=" + value;
    });
    return res;
  }
}

class BaseApi {
  static Future<String> get(String url, [Map params = null]) {
    // Stub API calls here.
    // return new Future.of(() => '{"available":true}');
    if (params != null) {
      url = new UrlBuilder(url, params).get();
    }
    return HttpRequest.getString(url);
  }
  
  static Future<String> post(url, [Map params= null]) {
    return HttpRequest.request(
        new UrlBuilder(url, params).get(),
        method: "POST"
    ).then((xhr) => xhr.responseText);
  }
}

class BaseJsonApi extends BaseApi {
  static Future<Map> get(String url, [Map params = null]) {
    return BaseApi.get(url, params).then((response) => parse(response));
  }
  
  static Future<Map> post(String url, [Map params = null]) {
    return BaseApi.post(url, params).then((response) => parse(response));
  }
}

