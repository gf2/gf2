part of models;


abstract class ReadingSection extends AbstractSection{
  String title;
  String image;
  List<String> paragraph;
}
/**
 * The model represents reading section.
 */
class ReadingSectionImpl extends JsonObject implements ReadingSection {
  
  ReadingSectionImpl();
  
  factory ReadingSectionImpl.fromJsonString(String jsonContent) {
    print(jsonContent);
    return new JsonObject.fromJsonString(jsonContent, new ReadingSectionImpl());
  }
}