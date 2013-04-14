part of api;

class UserManager {
  static final String LOCAL_STORAGE_KEY = 'user_info';
  static var user = null;
  
  // Singleton style. Return user info as a Map. null for logged out user.
  static Map getUser() {
    if (user == null) {
      if (!window.localStorage.containsKey(LOCAL_STORAGE_KEY)) {
        Map result = null;
        try {
          result = BaseJsonApi.getNow('/a/get_user_info');
          user = result["user"];
          window.localStorage[LOCAL_STORAGE_KEY] = stringify(user);
        } catch (e) {
          // TODO: Post client exceptions to server for debug & tracking.
          user = null;
        }
      } else {
        user = parse(window.localStorage[LOCAL_STORAGE_KEY]);
      }
    }
    return user;
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
  static final RegExp EMAIL_REGEX = new RegExp(
      r"[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}");
  
  String email = null;
  
  EmailChecker(email) {
    this.email = email;
  }
  
  Future<bool> check() {
    if (!EMAIL_REGEX.hasMatch(email)) {
      return new Future.of(() => false);
    } else {
      return BaseJsonApi.get('/a/check_email?email=' + email).then(
          (response) => response["available"]);
    }
  }
}
