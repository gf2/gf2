from handlers import BasePageHandler
from gaesessions import get_current_session
import webapp2
import hashlib
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
    session = get_current_session()
    session['me'] = user
    self.response.out.write('Signup successfully.')

class LogoutHandler(BasePageHandler):
  def get(self):
    pass

