from base_parser import BaseParser


class ReadingParser(BaseParser):

    # parse exam
    def parseExam(self, data):
        paragraphs = []
        questions = []
        question_to_paragraph = []
        question_points = []
        title = data[1]
        for index in range(2, len(data)):
            if data[index].startswith("Paragraph 1:"):
                break
            paragraphs.append(data[index])
        parts = self.splitBy(data[index:], r"Paragraph .*")

        index = 0
        for part in parts:
            i = 0
            for line in part:
                if line.startswith("Paragraph"):
                    index, content = self.getInitIndex(line.replace("Paragraph ", "", 1))
                    paragraphs[index - 1] = content
                else:
                    break
                i += 1

            list = self.splitBy(part[i:], r"[0-9][0-9]?\..*")
            for question in list:
                point = 1
                for line in question:
                    words = line.split(" ")
                    for j in range(1, len(words) - 1):
                        if words[j + 1] == "points":
                            point = int(words[i])
                            break
                question_points.append(point)
                questions.append(question)
                question_to_paragraph.append(index)
        return self.genJson(title, paragraphs, questions, question_to_paragraph, question_points)

    # Generate json
    def genJson(self, title, paragraphs, questions, question_to_paragraph, question_points):
        json_string = ""
        json_string += "{\n"
        json_string += "\t\"title\": \"%s\",\n" % title
        json_string += "\t\"image\": \"\",\n"
        json_string += "\t\"paragraphs\": [\n"
        for line in paragraphs:
            json_string += "\t\t\"%s\",\n" % line
        json_string += "\t],\n"

        json_string += "\t\"question\": [\n"
        index = 0
        for line in questions:
            json_string += "\t\t{\n"
            json_string += "\t\t\t\"type\": \"\",\n"
            json_string += "\t\t\t\"paragraph\": %d,\n" % question_to_paragraph[index]
            json_string += "\t\t\t\"point\": %d,\n" % question_points[index]
            json_string += "\t\t\t\"description\": \"%s\",\n" % line[0]
            json_string += "\t\t\t\"option\": [\n"
            for i in range(1, len(line)):
                json_string += "\t\t\t\t\"%s\",\n" % line[i]
            json_string += "\t\t\t],\n"
            json_string += "\t\t\t\"answer\" : 0,\n"
            json_string += "\t\t},\n"
            index += 1
        json_string += "\t],\n"
        json_string += "}"
        return json_string
        # json_string = json_string.replace('\t', '').replace('\n', '')
