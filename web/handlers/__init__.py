import configs
import jinja2
import json
import logging
import os
import webapp2
from gaesessions import get_current_session

jinja_environment = jinja2.Environment(
    loader = jinja2.FileSystemLoader(os.path.dirname(__file__))
)

class BasePageHandler(webapp2.RequestHandler):
  def __init__(self, request, response):
    webapp2.RequestHandler.__init__(self, request, response)

  def render(self, page_name, values = {}):
    template = jinja_environment.get_template("templates/" + page_name)
    values["uri_map"] = configs.uri_map
    self.response.out.write(template.render(values))

class BaseApiHandler(webapp2.RequestHandler):
  def render_dict_as_json(self, json_dict):
    if self.request.get("jsonp"):
      self.response.headers['Content-Type'] = 'text/javascript; charset=utf-8'
      self.response.out.write('%s(%s)' % (self.request.get("jsonp"), json.dumps(json_dict)))
    else:
      self.response.headers['Content-Type'] = 'application/json; charset=utf-8'
      self.response.out.write(json.dumps(json_dict))
  
  # alias
  def reply(self, json_dict):
    self.render_dict_as_json(json_dict)

def require_login(url):
  def login_check(fn):
    def Get(self, *args):
      if not get_current_session().has_key('me'):
        self.redirect(url)
        return
      else:
        fn(self, *args)
    return Get
  return login_check

