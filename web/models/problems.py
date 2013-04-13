from google.appengine.ext import db

class ProblemSet(db.Model):
  name = db.StringProperty(required = True)
  is_free = db.BooleanProperty(required = True)

class ProblemSetTry(db.Model):
  user = db.ReferenceProperty(User.key)
  problemset = db.ReferenceProperty(ProblemSet.key)
  score = db.IntegerProperty()
  answer = db.StringProperty()  # TODO: a json string?
  start_time = db.DateTimeProperty()
  end_time = db.DateTimeProperty()

class Problem(db.Model):
  pass
