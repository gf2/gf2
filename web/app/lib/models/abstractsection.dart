part of models;

abstract class AbstractSection {
  
  String type;
  
  factory AbstractSection.fromJsonString(String jsonContent) {
    Map parsedJson = parse(jsonContent);
    String type = parsedJson["type"];
    if (type == 'reading') {
      return new ReadingSectionImpl.fromJsonString(jsonContent);
    } else if (type == 'listening') {
      return new ListeningSectionImpl.fromJsonString(jsonContent);
    } else if (type == 'writing') {
      return new WritingSectionImpl.fromJsonString(jsonContent);
    } else if (type == 'speaking') {
      return new SpeakingSectionImpl.fromJsonString(jsonContent);
    } else {
      throw "Not supported section type";
    }
  }
}