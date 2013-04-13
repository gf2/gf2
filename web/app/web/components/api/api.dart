library api;

import 'dart:async';
import 'dart:html';
import 'dart:io';
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
    if (this.data) {
      this.url += "?";
      this.data.forEach((key, value) {
        if (!this.url.endsWith("?")) {
          this.url += "&";
        }
        this.url += key;
      });
    }
    return this.url;
  }
}

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
  
  static Future<Map> post(url, data) {
    
  }
}

