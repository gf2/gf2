from google.appengine.ext import db
from google.appengine.ext import testbed
import os
import gaesessions
import unittest
import webtest
import webapp2
import json
from handlers.problem import *
from handlers.user import *

class ProblemTest(unittest.TestCase):
  def setUp(self):
    self.testbed = testbed.Testbed()
    self.testbed.activate()
    self.testbed.init_datastore_v3_stub()
    app = webapp2.WSGIApplication([
        (r'/get_problemsets', GetProblemSetsHandler),
        (r'/add_problemset', AddProblemSetHandler),
        (r'/try_problemset', TryProblemSetHandler),
        (r'/login', LoginHandler),
        (r'/signup', SignupHandler),
    ]);
    app_with_sessions = gaesessions.SessionMiddleware(app,
        cookie_key=os.urandom(64))
    self.testapp = webtest.TestApp(app_with_sessions)
  
  def tearDown(self):
    self.testbed.deactivate()
  
  def login(self):
    params = {
      'email': 'roba269@gmail.com',
      'password': 'thisispwd',
    }
    self.testapp.post('/signup', params)
    resp = self.testapp.post('/login', params)
    os.environ['HTTP_COOKIE'] = resp.headers['Set-Cookie']

  def testGetProblemSets(self):
    params = {
      'problemset_id': 1,
      'problemset_name': 'TPO-1',
    }
    self.testapp.get('/add_problemset', params)
    params = {
      'problemset_id': 2,
      'problemset_name': 'TPO-2',
    }
    self.testapp.get('/add_problemset', params)
    self.login()
    self.testapp.get('/try_problemset?problemset_id=2')
    response = self.testapp.get('/get_problemsets')
    resp = json.loads(response.normal_body)
    self.assertEqual(resp['status'], 'OK')
    self.assertEqual(resp['num_results'], 2)
    for item in resp['results']:
      if item['problemset_id'] == 1:
        self.assertEqual(item['has_completed'], False)
      elif item['problemset_id'] == 2:
        self.assertEqual(item['has_completed'], True)

