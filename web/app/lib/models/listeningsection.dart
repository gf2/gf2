part of models;


abstract class ListeningSection extends AbstractSection {
  String audio;
  String image;
  List<String> paragraph;
}
/**
 * The model represents reading section.
 */
class ListeningSectionImpl extends JsonObject implements ListeningSection {
  
  ListeningSectionImpl();
  
  factory ListeningSectionImpl.fromJsonString(String jsonContent) {
    print(jsonContent);
    return new JsonObject.fromJsonString(jsonContent, new ListeningSectionImpl());
  }
}