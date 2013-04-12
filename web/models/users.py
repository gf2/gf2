from google.appengine.ext import db

class User(db.Model):
  email = db.EmailProperty()
  uid = db.IntegerProperty()
  nickname = db.StringProperty()
  created_time = db.DateTimeProperty(auto_now_add = True)
  password = db.StringProperty()
  status = db.IntegerProperty()   # User's payment status

