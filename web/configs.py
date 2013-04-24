'''
Global configs

Created on Apr 7, 2013

@author: charliez
'''

DEBUG = True

uri_map = {
    "upload_audio_form" : r'/upload_audio_form',
    "upload_audio" : r'/upload_audio',
    "play_audio" : r'/play_audio/([^/]+)?',
    "home_page": r'/',
    "login": r'/a/login',
    "logout": r'/a/logout',
    "signup": r'/a/signup',
    "get_user_info": r'/a/get_user_info',
    "signup_page": r'/p/signup',
    "check_email": r'/a/check_email',
    "get_problemsets": r'/a/get_problemsets',
    "get_section": r'/a/get_section',
}

