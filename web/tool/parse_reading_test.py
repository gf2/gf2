import unittest
import parse_reading


class TestParseReading(unittest.TestCase):
    def testParse(self):
        parse_reading.ParseReading().parse()
