import unittest
from gql_json import GqlJson
from google.appengine.ext import db


class TestEntity(db.Model):
    name = db.StringProperty(required=True)
    date = db.DateProperty(auto_now_add=True)
    flag = db.BooleanProperty(indexed=False)


class TestGqlJson(unittest.TestCase):
    def testEncode(self):
        entity = TestEntity(name="tao")
        json = GqlJson().encode(entity)
        self.assertEqual('{\'date\': datetime.date(2013, 4, 11), \'flag\': None, \'name\': \'tao\'}', json.__str__())