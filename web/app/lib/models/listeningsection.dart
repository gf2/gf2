part of models;

class ListeningSection extends AbstractSection {
  String audio;
  String image;
  List<String> paragraph;
  
  ListeningSection();
  
  factory ListeningSection.fromJsonString(String jsonContent) {
    ListeningSection listeningSection = new ListeningSection();
    Map parsedJson = parse(jsonContent);
    AbstractSection.parseCommonData(parsedJson, listeningSection);
    listeningSection.audio = parsedJson['audio'];
    listeningSection.image = parsedJson['image'];
    listeningSection.paragraph = parsedJson['paragraph'];
    return listeningSection;
  }
}
