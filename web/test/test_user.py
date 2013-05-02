from google.appengine.ext import db
from google.appengine.ext import testbed
import os
import gaesessions
import unittest
import webtest
import webapp2
import json
from handlers.user import *

class UserTest(unittest.TestCase):
  def setUp(self):
    self.testbed = testbed.Testbed()
    self.testbed.activate()
    self.testbed.init_datastore_v3_stub()
    app = webapp2.WSGIApplication([
        (r'/login', LoginHandler),
        (r'/logout', LogoutHandler),
        (r'/signup', SignupHandler),
        (r'/check_email', CheckEmailHandler),
    ]);
    app_with_sessions = gaesessions.SessionMiddleware(app,
        cookie_key=os.urandom(64))
    self.testapp = webtest.TestApp(app_with_sessions)
  def tearDown(self):
    self.testbed.deactivate()
  def testSignupAndLogin(self):
    # test signup
    params = {
      'email': 'roba269',
      'password': 'thisispwd'
    }
    response = self.testapp.post('/signup', params)
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['result'], 'INVALID_EMAIL')
    params = {
      'email': 'roba269@gmail.com',
      'password': 'short'
    }
    response = self.testapp.post('/signup', params)
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['result'], 'INVALID_PASSWORD')
    params = {
      'email': 'roba269@gmail.com',
      'password': '123456'
    }
    response = self.testapp.post('/signup', params)
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['result'], 'SUCCESS')
    params = {
      'email': 'roba269@gmail.com',
      'password': 'abcdefg'
    } 
    response = self.testapp.post('/signup', params)
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['result'], 'EMAIL_USED')
    
    # test login
    params = {
      'email': 'roba269@gmail.com',
      'password': 'wrong_pwd',
    }
    response = self.testapp.post('/login', params)
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['result'], 'FAILURE')
    params = {
      'email': 'roba269@gmail.com',
      'password': '123456',
    }
    response = self.testapp.post('/login', params)
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['result'], 'SUCCESS')
    session = get_current_session()
    self.assertEqual(session['me'].email, 'roba269@gmail.com')
    
    # test logout
    self.testapp.get('/logout')
    session = get_current_session()
    self.assertTrue('me' not in session)
    
    # test check_email 
    response = self.testapp.get('/check_email?email=roba269@gmail.com')
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['available'], False)
    response = self.testapp.get('/check_email?email=notexist@gmail.com')
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['available'], True)

if __name__ == '__main__':
  unittest.main()
