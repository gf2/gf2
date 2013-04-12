import simplejson
from google.appengine.ext import db


class GqlJson():
    def encode(self, obj):
        if isinstance(obj, db.Model):
            properties = obj.properties().items()
            result = {}
            for key, value in properties:
                result[key] = getattr(obj, key)
            return result

        if isinstance(obj, db.GqlQuery):
            return list(obj)

        if hasattr(obj, '__json__'):
            return getattr(obj, '__json__')()

        return simplejson.JSONEncoder().default(obj)