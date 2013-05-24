part of models;

abstract class AbstractSection extends JsonObject {
  
  String type;
  
  List<AbstractQuestion> questions;

  AbstractSection();
  
  factory AbstractSection.fromJsonString(String jsonContent) {
    Map parsedJson = parse(jsonContent);
    String type = parsedJson["type"];
    if (type == 'reading') {
      return new ReadingSection.fromJsonString(jsonContent);
    } else if (type == 'listening') {
      return new ListeningSection.fromJsonString(jsonContent);
    } else if (type == 'writing') {
      return new WritingSection.fromJsonString(jsonContent);
    } else if (type == 'speaking') {
      return new SpeakingSection.fromJsonString(jsonContent);
    } else {
      throw "Not supported section type:" + type;
    }
  }
  
  static parseCommonData(Map parsedJson, AbstractSection section) {
    section.type = parsedJson['type'];
  }
}