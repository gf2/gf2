import datetime
from handlers import BasePageHandler
from handlers import BaseApiHandler
from handlers import require_login
from gaesessions import get_current_session
from models.users import User
from models.problems import *
import webapp2

# this is just for testing other functions
class AddProblemSetHandler(BaseApiHandler):
  def get(self):
    ps = ProblemSet(
        name = self.request.get('problemset_name'),
        is_free = True)
    ps.put()
    self.reply({"result": "SUCCESS"})

class TryProblemSetHandler(BaseApiHandler):
  def get(self):
    pst = ProblemSetTry()
    pst.problemset = db.get(db.Key(self.request.get('problemset_id')))
    pst.score = 60
    pst.start_time = datetime.datetime.now()
    pst.end_time = datetime.datetime.now()
    pst.put()
    self.reply({"result": "SUCCESS"})

class GetProblemSetsHandler(BaseApiHandler):
  @require_login('/a/login')
  def get(self):
    problem_sets = ProblemSet.gql("")
    result = []
    for problem_set in problem_sets:
      pass  
    self.reply({"result": "SUCCESS"})   
