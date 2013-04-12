import entity

_LISTENING_FILE = "listening"
_READING_FILE = "reading"


class EntityParser:
    def passSimpleListening(self, filename, data):
        print filename
        parts = filename.split(".")[0].split("_")
        problem_set = entity.ProblemSet(name=parts[2],
                                        year=int(parts[1]));
        section = entity.Section(type=entity._SECTION_TYPE_LISTENING)

        problems = []
        line_count = 0
        lines = []
        for line in data:
            line = line.replace('\n', '')
            lines.append(line)
            if line_count % 5 == 4:
                problem = entity.ListeningSimpleProblem(question=lines[0])
                problem.option_a = lines[1]
                problem.option_b = lines[2]
                problem.option_c = lines[3]
                problem.option_d = lines[4]
                problems.append(problem)
                lines = []
            line_count += 1

        return [problem_set, section, problems]
