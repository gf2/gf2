part of models;

class ReadingSection extends AbstractSection {
  String title;
  String image;
  List<String> paragraph;
  List<AbstractQuestion> questions;
  
  ReadingSection();
  
  factory ReadingSection.fromJsonString(String jsonContent) {
    ReadingSection readingSection = new ReadingSection();
    Map parsedJson = parse(jsonContent);
    readingSection.title = parsedJson['title'];
    readingSection.image = parsedJson['pargraph'];
    List<AbstractQuestion> questions =
        AbstractQuestion.createQuestionsFromList(parsedJson['questions']);
    readingSection.questions = questions;
    return readingSection;
  }
}
