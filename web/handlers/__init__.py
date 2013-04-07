import configs
import jinja2
import json
import logging
import os
import webapp2

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