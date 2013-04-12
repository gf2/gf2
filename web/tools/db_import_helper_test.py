import unittest
import os
import glob
import entity
import db_import_helper as importer


class TestDBImportHelper(unittest.TestCase):
    def testImportText(self):
        importer.DBImportHelper().importText()

    def testReadTXT(self):
        os.chdir(importer._DEFAULT_EXAM_FOLDER)
        files = glob.glob("listening_2010_real.txt")
        file = files[0]
        entities = importer.DBImportHelper().readTXT(file)
        self.assertEqual(entities[0].name, "real")
        self.assertEqual(entities[1].type, entity._SECTION_TYPE_LISTENING)
        print entities[2][0].question
        self.assertEqual(entities[2][0].question, "1. Why does the student go to see the librarian?")