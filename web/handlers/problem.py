import datetime
from handlers import BasePageHandler
from handlers import BaseApiHandler
from handlers import require_login
from gaesessions import get_current_session
from models.users import User
from models.problems import *
import webapp2
import logging

# this is just for testing other functions
class AddProblemSetHandler(BaseApiHandler):
  def get(self):
    ps = ProblemSet(
        name = self.request.get('problemset_name'),
        is_free = True)
    ps.put()
    self.reply({"result": "SUCCESS"})

def get_problemset_by_name(name):
  res = ProblemSet.gql("WHERE name = :1", name)
  if res.count():
    return res[0]
  return None

# this is just for testing other functions
class TryProblemSetHandler(BaseApiHandler):
  @require_login('/a/login')
  def get(self):
    pst = ProblemSetTry()
    pst.user = get_current_session()['me']
    name = self.request.get('problemset_name')
    if len(name):
      pst.problemset = get_problemset_by_name(name)
      if not pst.problemset:
        self.reply({"result": "name not found"})
        return
    else:
      psid = self.request.get('problemset_id')
      if len(psid):
        pst.problemset = db.get(db.Key(psid))
      else:
        self.reply({"result": "parameter error"})
        return
    pst.score = 60
    pst.start_time = datetime.datetime.now()
    pst.end_time = datetime.datetime.now()
    pst.put()
    self.reply({"result": "SUCCESS"})

# this is just for testing other functions
class PayProblemSetHandler(BaseApiHandler):
  def get(self):
    pass

def has_completed(user_key, problemset_key):
  res = ProblemSetTry.gql("WHERE user = :1 AND problemset = :2", user_key, problemset_key)
  return res.count() > 0

class GetProblemSetsHandler(BaseApiHandler):
  @require_login('/a/login')
  def get(self):
    problem_sets = ProblemSet.gql(
      "LIMIT %s,%s" %
      (self.request.get("offset", "0"),
      self.request.get("limit", "10"))
    )
    results = []
    for problem_set in problem_sets:
      logging.info(problem_set.key)
      results.append({
        "name": problem_set.name,
        "is_free": problem_set.is_free,
        "has_completed": has_completed(
          get_current_session()['me'].key(),
          problem_set.key()),
      })
    self.reply({"status": "OK",
      "num_results": len(results),
      "results": results
    })
