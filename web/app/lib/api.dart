part of gf2lib;

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
  static String getNow(String url, [Map params = null]) {
    //return '{"user":{"email":"a@b.com","nickname":"zero"}}'; // TODO
    if (params != null) {
      url = new UrlBuilder(url, params).get();
    }
    HttpRequest req = new HttpRequest();
    req.open("GET", url, async: false);
    req.send();
    return req.responseText;
  }
  
  static Future<String> get(String url, [Map params = null]) {
    if (params != null) {
      url = new UrlBuilder(url, params).get();
    }
    return HttpRequest.getString(url);
  }
  
  static Future<String> post(url, [Map params= null]) {
    // return new Future.sync(() => '{"result":"FAILURE"}'); // TODO
    return HttpRequest.request(
        new UrlBuilder(url, params).get(),
        method: "POST"
    ).then((xhr) => xhr.responseText);
  }
}

class BaseJsonApi extends BaseApi {
  static Map getNow(String url, [Map params = null]) {
    return parse(BaseApi.getNow(url, params));
  }
  
  static Future<Map> get(String url, [Map params = null]) {
    return BaseApi.get(url, params).then((response) => parse(response));
  }
  
  static Future<Map> post(String url, [Map params = null]) {
    // return new Future.sync(() => "STUB"); // TODO
    return BaseApi.post(url, params).then((response) => parse(response));
  }
}

