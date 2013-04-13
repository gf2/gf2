from handlers import BasePageHandler
from gaesessions import get_current_session
from models.users import User
from models.problems import *
import webapp2

# this is just for testing other functions
class AddProblemSetHandler(BasePageHandler):
  def get(self):
    ps = ProblemSet()
    ps.name = self.request.get('problem_name')
    ps.is_free = True
    ps.put()

class TryProblemSetHandler(BasePageHandler):
  def get(self):
    pst = ProblemSetTry()
    pst.problemset = db.get(self.request.get('problem_set_id'))
    pst.score = 60
    pst.start_time = datetime.datetime.now()
    pst.end_time = datatime.datetime.now()
    pst.put()

class GetProblemSetsHandler(BasePageHandler):
  def get(self):
    # TODO: require login
    ProblemSet.gql("")
