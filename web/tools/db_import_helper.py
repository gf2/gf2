"""
    Tool to import exam data into datastore.
"""
import os
import glob
import entity_parser as parser

_DEFAULT_EXAM_FOLDER = "../exams"


class DBImportHelper():
    def readTXT(self, filename):
        with open(filename) as file:
            data = file.readlines()
            if parser._LISTENING_FILE in filename:
                return parser.EntityParser().passSimpleListening(filename, data)

    def importText(self):
        os.chdir(_DEFAULT_EXAM_FOLDER)
        files = glob.glob("*.*")
        for file in files:
            if file.endswith("doc"):
                print "%s is doc" % file
            if file.endswith("txt"):
                print "%s is txt" % file
                self.readTXT(file)

