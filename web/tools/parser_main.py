import sys
from reading_parser import ReadingParser
from listening_parser import ListeningParser


def main():
    ListeningParser().parse("../exams", "listening")

if __name__ == "__main__":
    sys.exit(main())
