import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:app/models.dart';
import 'package:app/requests.dart';

class ReadingSectionComponent extends WebComponent {
  //TODO(Nicholas): Add logic here.
  
  ReadingSection readingSection;
  GetSectionRequest request;
  int currentQuestionIdx;

  String  apiurl;
  String sectionid;

  List<ParagraphElement> paragraphs = new List<ParagraphElement>();
  
  Element nextQuestionEle;
  Element previousQuestionEle;
  
  void created() {
    print("ReadingComponent created.");
  }
  
  void inserted() {
    if (request == null) {
      if (apiurl != null) {
        request = new GetSectionRequest(sectionid, url: apiurl);
      } else {
        request = new GetSectionRequest(sectionid);
      }
      request.getSection().then((AbstractSection readingSection) 
          => initRender(readingSection));
    }
    initQuestionControl();
  }
  
  initRender(ReadingSection readingSection) {
    DivElement paragraphWrapper = query("#paragraph-wrapper");
    this.readingSection = readingSection;
    for (String paragraph in readingSection.paragraphs) {
      ParagraphElement pElement = new ParagraphElement();
      pElement.text = paragraph;
      paragraphs.add(pElement);
      paragraphWrapper.append(pElement);
    }
    setCurrentQuestionIdx(0);
  }
  
  bool setCurrentQuestionIdx(int currentQuestionIdx) {
    if (currentQuestionIdx < 0) {
      return false;
    }
    if (currentQuestionIdx >= readingSection.questions.length) {
      return false;
    }
    assert(currentQuestionIdx >= 0 &&
        currentQuestionIdx < this.readingSection.questions.length);
    this.currentQuestionIdx = currentQuestionIdx;
    DivElement questionWrapper = query("#question-content");
    questionWrapper.innerHtml = "";
    AbstractQuestion question = readingSection.questions[currentQuestionIdx];
    if (question is MultiChoiceQuestion) {
      MultiChoiceQuestion multiChoiceQuestion = question;
      ParagraphElement description = new ParagraphElement();
      description.text = multiChoiceQuestion.description;
      questionWrapper.append(description);
    }
    
    if (currentQuestionIdx == 0) {
      previousQuestionEle.hidden = true;
    } else {
      previousQuestionEle.hidden = false;
    }
    
    if (currentQuestionIdx == readingSection.questions.length - 1) {
      nextQuestionEle.hidden = true;
    } else {
      nextQuestionEle.hidden = false;
    }
    return true;
  }

  
  void initQuestionControl() {
    nextQuestionEle = query("#next-question");
    previousQuestionEle = query("#previous-question");
    nextQuestionEle.onClick.listen((e) => nextQuestion(e));
    previousQuestionEle.onClick.listen((e) => previousQuestion(e));
  }
  
  void nextQuestion(MouseEvent event) {
    setCurrentQuestionIdx(currentQuestionIdx + 1);
  }
  
  void previousQuestion(MouseEvent event) {
    setCurrentQuestionIdx(currentQuestionIdx - 1);
  }
}