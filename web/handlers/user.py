from google.appengine.api import mail
from handlers import BasePageHandler
from handlers import BaseApiHandler
from gaesessions import get_current_session
import webapp2
import hashlib
import re
import logging
import random
import string
from datetime import datetime, timedelta
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

def get_user_by_email(email):
  return User.gql("WHERE email=:1", email).get() 
  
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

# /a/signup
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

# /a/check_email
class CheckEmailHandler(BaseApiHandler):
  def get(self):
    self.reply(
      {
        "available": not email_exist(self.request.get('email'))
      })

# /a/get_user_info
class UserInfoHandler(BaseApiHandler):
  def get(self):
    self.reply(
      {
        "status": "OK",
        "user": {
          "nickname": "Zero",
          "email": "zero@gmail.com",
          "language": "ch",
          "country": "CN"
        }
      })

def gen_random_key(n):
  return ''.join(random.choice(
    string.ascii_letters + string.digits) for x in range(n))

# /a/send_reset_password_email
class SendResetPasswordEmailHandler(BaseApiHandler):
  def get(self):
    # TODO: just for simplify the testing, should be removed in prod 
    self.post()
  def post(self):
    email = self.request.get('email')
    user = get_user_by_email(email)
    if user is None:
      self.reply({"result": "EMAIL_NOT_EXIST"})
      return
    key = gen_random_key(20)
    # TODO: sender and body to be determined
    mail.send_mail(
      sender = "support@gf2.appspotmail.com",
      to = email,
      subject = "Password reset",
      body = """
        The key for resetting you password: %s
      """ % key)
    user.pwd_reset_key_hashed = hashlib.sha1(key).hexdigest()
    user.pwd_reset_timeout = datetime.now() + timedelta(hours=12)
    user.put()
    self.reply({"result": "SUCCESS"})

# /a/reset_password
class ResetPasswordHandler(BaseApiHandler):
  def get(self):
    # TODO: just for simplify the testing, should be removed in prod 
    self.post()
  def post(self):
    user = get_user_by_email(self.request.get("email"))
    if user is None:
      self.reply({"result": "FAILURE"})
      return
    hashed_key = hashlib.sha1(self.request.get('key')).hexdigest()
    if hashed_key != user.pwd_reset_key_hashed or \
        datetime.now() > user.pwd_reset_timeout:
      self.reply({"result": "FAILURE"})
      return
    new_pwd = hashlib.sha1(self.request.get('password')).hexdigest()
    user.password = new_pwd
    user.pwd_reset_key_hashed = None
    user.pwd_reset_timeout = None
    user.put()
    self.reply({"result": "SUCCESS"})

