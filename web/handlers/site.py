'''
Created on Apr 7, 2013

@author: charliez
'''

from handlers import BasePageHandler

class HomePageHandler(BasePageHandler):
    def get(self):
        self.render('home.html')
