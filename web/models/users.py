from google.appengine.ext import db

class User(db.Model):
  email = db.EmailProperty()
  uid = db.IntegerProperty()
  nickname = db.StringProperty()
  created_time = db.DateTimeProperty(auto_now_add = True)
  password = db.StringProperty()
  status = db.IntegerProperty()   # User's payment status
  paid_problemsets = db.ListProperty(db.Key)
  pwd_reset_key_hashed = db.StringProperty()
  pwd_reset_timeout = db.DateTimeProperty()

