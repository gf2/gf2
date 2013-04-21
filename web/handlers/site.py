'''
Created on Apr 7, 2013

@author: charliez
'''

from handlers import BasePageHandler
from gaesessions import get_current_session

class HomePageHandler(BasePageHandler):
    def get(self):
        session = get_current_session()
        if session.has_key('me'):
          self.redirect('/app.html')
        else:
          self.redirect('/welcome.html')
