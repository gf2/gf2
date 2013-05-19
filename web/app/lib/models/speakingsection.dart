part of models;


abstract class SpeakingSection extends AbstractSection{
  List<String> questions;
}
/**
 * The model represents speaking section.
 */
class SpeakingSectionImpl extends JsonObject implements SpeakingSection {
  
  SpeakingSectionImpl();
  
  factory SpeakingSectionImpl.fromJsonString(String jsonContent) {
    return new JsonObject.fromJsonString(jsonContent, new SpeakingSectionImpl());
  }
}