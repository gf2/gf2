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
    name = self.request.get('problemset_name')
    pid = int(self.request.get('problemset_id', '0'))
    if pid == 0 or get_problemset_by_id(pid):
      self.reply({"result": "ERROR (Empty or existence id)"})
      return
    ps = ProblemSet(problemset_id = pid, name = name, is_free = True)
    ps.put()
    self.reply({"result": "SUCCESS"})

def get_problemset_by_id(pid):
  res = ProblemSet.gql("WHERE problemset_id = :1", pid)
  if res.count():
    return res[0]
  return None

# this is just for testing other functions
class TryProblemSetHandler(BaseApiHandler):
  @require_login('/a/login')
  def get(self):
    pst = ProblemSetTry()
    pst.user = get_current_session()['me']
    pid = int(self.request.get('problemset_id', '0'))
    pst.problemset = get_problemset_by_id(pid)
    if not pst.problemset:
      self.reply({"result": "id not found"})
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

class GetSectionHandler(BaseApiHandler):
  def get(self):
    response = {
        "type": "reading",
        "title": "This is reading title",
        "image": "/static/img/xxx.jpb",
        "paragraphs": [
          "First paragraph",
          "Second paragraph",
          "Third paragraph"
        ],
        "question": [
          {
            "type": "multichoice",
            "paragrapha": 0,
            "points": 1,
            "options": [
              "option 1",
              "option 2",
              "option 2"
            ],
            "answer" : 0,
          }
        ]
    }
    self.reply(response)


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
        "problemset_id": problem_set.problemset_id,
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
