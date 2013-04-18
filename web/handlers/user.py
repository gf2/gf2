from handlers import BasePageHandler
from handlers import BaseApiHandler
from gaesessions import get_current_session
import webapp2
import hashlib
import re
import logging
from models.users import User

class LoginHandler(BasePageHandler):
  def get(self):
    self.render('login.html')
  def post(self):
    users = User.gql("WHERE email=:1", self.request.get('email'))
    if users.count() == 0 or \
      users[0].password != hashlib.sha1(self.request.get('password')).hexdigest():
      self.response.out.write('Login failed.')
    else:
      # add session    
      session = get_current_session()
      session['me'] = users[0]    
      self.response.out.write('Login successfully.')

def email_exist(email):
  return User.gql("WHERE email=:1", email).get() is not None

EMAIL_REGEX = re.compile(r"[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}")

def is_valid_email(email):
  if not EMAIL_REGEX.match(email):
    return False
  return True

def is_valid_password(password):
  return len(password) >= 6

class SignupPageHandler(BasePageHandler):
  def get(self):
    self.render('signup.html')

class SignupHandler(BaseApiHandler):  
  def post(self):
    email = self.request.get('email')
    password = self.request.get('password')
    logging.info(email)
    logging.info(is_valid_email(email))
    if not is_valid_email(email):
      return self._result("INVALID_EMAIL")
    if not is_valid_password(password):
      return self._result("INVALID_PASSWORD")
    if email_exist(email):
      self._result("EMAIL_USED")
      return
    user = User()
    user.email = email
    user.nickname = self.request.get('nickname')
    user.password = hashlib.sha1(password).hexdigest()
    user.put()
    session = get_current_session()
    session['me'] = user
    self._result("SUCCESS")
  
  # utility
  def _result(self, res):
    self.reply({"result": res})

class LogoutHandler(BaseApiHandler):
  def get(self):
    session = get_current_session()
    session.terminate()
    self.reply({"result": "SUCCESS"})

class GetUserInfoHandler(BaseApiHandler):
  def get(self):
    if session['me']:
      self.render_dict_as_json({
        "user": {
          "nickname": session['me'].nickname,
          "email": session['me'].email,
        },
        "status": "OK"
      })
    else:
      self.render_dict_as_json({
        "status": "LOGGED_OUT"
      });

class CheckEmailHandler(BaseApiHandler):
  def get(self):
    self.reply(
      {
        "available": not email_exist(self.request.get('email'))
      })
