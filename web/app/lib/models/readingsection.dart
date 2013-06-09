part of models;

class ReadingSection extends AbstractSection {
  String title;
  String image;
  List<String> paragraphs;
  List<AbstractQuestion> questions;
  
  ReadingSection();
  
  factory ReadingSection.fromJsonString(String jsonContent) {
    ReadingSection readingSection = new ReadingSection();
    Map parsedJson = parse(jsonContent);
    readingSection.title = parsedJson['title'];
    readingSection.paragraphs = parsedJson['paragraphs'];
    readingSection.image = parsedJson['image'];
    List<AbstractQuestion> questions =
        AbstractQuestion.createQuestionsFromList(parsedJson['questions']);
    readingSection.questions = questions;
    return readingSection;
  }
}
