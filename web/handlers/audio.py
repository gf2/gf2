'''
Created on Apr 7, 2013

@author: charliez
'''

from google.appengine.ext import blobstore
from google.appengine.ext import db
from google.appengine.ext import webapp
from google.appengine.ext.webapp import blobstore_handlers
from configs import *

class Audio(db.Model):
  blob_key = blobstore.BlobReferenceProperty()

class AudioUploadFormHandler(webapp.RequestHandler):
  def get(self):
    upload_url = blobstore.create_upload_url('/upload_audio')
    # The method must be "POST" and enctype must be set to "multipart/form-data".
    self.response.out.write('<html><body>')
    self.response.out.write('<form action="%s" method="POST" enctype="multipart/form-data">' % upload_url)
    self.response.out.write('''Upload File: <input type="file" name="file"><br> <input type="submit"
        name="submit" value="Submit"> </form></body></html>''')

class AudioUploadHandler(blobstore_handlers.BlobstoreUploadHandler):
  def post(self):
    try:
      upload = self.get_uploads()[0]
      audio = Audio(blob_key=upload.key())
      db.put(audio)
      self.redirect('/play_audio/%s' % upload.key())
    except Exception as e:
      self.response.out.write('upload failed.')
      if DEBUG:
        self.response.out.write(str(e))

class AudioPlayHandler(blobstore_handlers.BlobstoreDownloadHandler):
  def get(self, audio_key):
    if not blobstore.get(audio_key):
      self.error(404)
    else:
      self.send_blob(audio_key)
