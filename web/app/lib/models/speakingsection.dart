part of models;


class SpeakingSection extends AbstractSection {
  String type;
  List<AbstractQuestion> questions;
  
  SpeakingSection();
  
  factory SpeakingSection.fromJsonString(String jsonContent) {
    SpeakingSection speakingSection = new SpeakingSection();
    Map parsedJson = parse(jsonContent);
    AbstractSection.parseCommonData(parsedJson, speakingSection);
    List<Map> questionsList = parsedJson['questions'];
    assert(questionsList.length == 6);
    List<AbstractQuestion> questions = new List<AbstractQuestion>();
    questions.add(
        new TopicSpeakingQuestion.fromMap(questionsList.elementAt(0)));
    questions.add(
        new TopicSpeakingQuestion.fromMap(questionsList.elementAt(1)));
    questions.add(
        new OpinionSpeakingQuestion.fromMap(questionsList.elementAt(2)));
    questions.add(
        new OpinionSpeakingQuestion.fromMap(questionsList.elementAt(3)));
    questions.add(
        new ListenSpeakingQuestion.fromMap(questionsList.elementAt(4)));
    questions.add(
        new ListenSpeakingQuestion.fromMap(questionsList.elementAt(5)));
    speakingSection.questions = questions;
    return speakingSection;
  }
}
