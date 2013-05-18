part of models;


abstract class WritingSection extends AbstractSection{
  String title;
  String image;
  List<String> paragraph;
}
/**
 * The model represents reading section.
 */
class WritingSectionImpl extends JsonObject implements WritingSection {
  
  WritingSectionImpl();
  
  factory WritingSectionImpl.fromJsonString(String jsonContent) {
    print(jsonContent);
    return new JsonObject.fromJsonString(jsonContent, new WritingSectionImpl());
  }
}