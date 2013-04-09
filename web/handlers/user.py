from google.appengine.ext import db
from handlers import BasePageHandler
import webapp2
import hashlib

class User(db.Model):
  email = db.EmailProperty()
  nickname = db.StringProperty()
  created_time = db.DateTimeProperty(auto_now_add = True)
  password = db.StringProperty()
  status = db.IntegerProperty()   # User's payment status

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
      self.response.out.write('Login successfully.')

class SignupHandler(BasePageHandler):
  def get(self):
    self.render('signup.html')
  def post(self):
    users = User.gql("WHERE email=:1", self.request.get('email'))
    if users.count() > 0:
      self.response.out.write('Email alreay exists.')
      return
    user = User()
    user.email = self.request.get('email')
    user.nickname = self.request.get('nickname')
    user.password = hashlib.sha1(self.request.get('password')).hexdigest()
    user.put()
    self.response.out.write('Signup successfully.')

class LogoutHandler(BasePageHandler):
  def get(self):
    pass

