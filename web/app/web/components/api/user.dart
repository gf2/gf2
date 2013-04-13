part of api;

class EmailChecker {
  static RegExp emailExp = new RegExp(
      r"[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}");
  
  String email = null;
  
  EmailChecker(email) {
    this.email = email;
  }
  
  Future<bool> check(func) {
    if (!emailExp.hasMatch(email)) {
      func(false);
    } else {
      return BaseJsonApi.get('/a/check_email?email=' + email).then(
          (response) => response["available"]).then(func);
    }
  }
}
