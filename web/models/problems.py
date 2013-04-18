from google.appengine.ext import db
from models.users import User

class Problem(db.Model):
  pass

class Answer(db.Model):
  pass

class ProblemSet(db.Model):
  problemset_id = db.IntegerProperty()
  name = db.StringProperty()
  is_free = db.BooleanProperty()
  desc = db.StringProperty()

class ProblemSetTry(db.Model):
  user = db.ReferenceProperty(User)
  problemset = db.ReferenceProperty(ProblemSet)
  score = db.IntegerProperty()
  answer = db.ReferenceProperty(Answer)
  start_time = db.DateTimeProperty()
  end_time = db.DateTimeProperty()

