part of api;

class UserHelper {
  static getUser() {
   // BaseJsonApi.get()
  }
  
  static login(email, password) {
    
  }
  
  static signup(email, nickname, password) {
    return BaseJsonApi.post(
        '/a/signup', {"email":email,"nickname": nickname, "password": password}).then(
            (response) => response["result"]);
  }
}

class EmailChecker {
  static RegExp emailExp = new RegExp(
      r"[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}");
  
  String email = null;
  
  EmailChecker(email) {
    this.email = email;
  }
  
  Future<bool> check() {
    if (!emailExp.hasMatch(email)) {
      func(false);
    } else {
      return BaseJsonApi.get('/a/check_email?email=' + email).then(
          (response) => response["available"]);
    }
  }
}
