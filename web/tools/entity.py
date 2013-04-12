from google.appengine.ext import db

_SECTION_TYPE_LISTENING = 0


class ProblemSet(db.Model):
    name = db.StringProperty(required=True)
    year = db.IntegerProperty(required=True)


class Section(db.Model):
    type = db.IntegerProperty(required=True)


class ListeningSimpleProblem(db.Model):
    question = db.StringProperty(required=True,multiline=True)
    option_a = db.StringProperty(multiline=True)
    option_b = db.StringProperty(multiline=True)
    option_c = db.StringProperty(multiline=True)
    option_d = db.StringProperty(multiline=True)
