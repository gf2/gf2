#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
import webapp2
from handlers.audio import *
from handlers.site import *
from handlers.user import *
from handlers.problem import *
from configs import *

app = webapp2.WSGIApplication([
    (uri_map['upload_audio'], AudioUploadHandler),
    (uri_map['upload_audio_form'], AudioUploadFormHandler),
    (uri_map['play_audio'], AudioPlayHandler),
    (uri_map['home_page'], HomePageHandler),
    (uri_map['login'], LoginHandler),
    (uri_map['logout'], LogoutHandler),
    (uri_map['signup'], SignupHandler),
    (uri_map['signup_page'], SignupPageHandler),
    (uri_map['check_email'], CheckEmailHandler),
    (uri_map['get_problemsets'], GetProblemSetsHandler),
    # below urls are just for test
    (r'/a/add_problemset', AddProblemSetHandler),
    (r'/a/try_problemset', TryProblemSetHandler),
    (r'/a/pay_problemset', PayProblemSetHandler),
], debug=True)
