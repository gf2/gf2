part of models;

class WritingSection extends AbstractSection {
  String title;
  String image;
  List<String> paragraph;
  
  WritingSection();
  
  factory WritingSection.fromJsonString(String jsonContent) {
    WritingSection writingSection = new WritingSection();
    Map parsedJson = parse(jsonContent);
    AbstractSection.parseCommonData(parsedJson, writingSection);
    writingSection.image = parsedJson['image'];
    List<AbstractQuestion> questions = new List<AbstractQuestion>();
    List<Map> questionsList = parsedJson['questions'];
    assert(questionsList.length == 2);
    questions.add(
        new WritingShortQuestion.fromMap(questionsList.elementAt(0)));
    questions.add(
        new WritingLongQuestion.fromMap(questionsList.elementAt(1)));
    return writingSection;
  }
}
