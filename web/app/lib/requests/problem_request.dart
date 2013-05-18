part of requests;

/**
 * The request to fetch a section data.
 */
class GetSectionRequest {
  
  static final API_URL = "/a/get_section";
  
  String sectionId;
  String url = API_URL;
  
  GetSectionRequest(String sectionId, {String url}) {
     this.sectionId = sectionId;
     if (url != null) {
       this.url = url;
     }
  }
   
  Future<AbstractSection> getSection() {
     Future request = HttpRequest.getString(url);
     Completer completer = new Completer<AbstractSection>();
     request
        .then((response) => completer.complete(parseResponse(response)))
        .catchError((e) => completer.completeError(e));
     return completer.future;
  }
  
  AbstractSection parseResponse(String response) {
    return new AbstractSection.fromJsonString(response);
  }
}