part of models;

abstract class AbstractQuestion {
  String type;
  int point;
  
  static List<AbstractQuestion> createQuestionsFromList(List<Map> questionsList) {
    print("create questions called.");
    List<AbstractQuestion> questions = new List<AbstractQuestion>();
    for (Map map in questionsList) {
      questions.add(new AbstractQuestion.fromMap(map));
    }
    return questions;
  }
  
  AbstractQuestion();
  
  factory AbstractQuestion.fromMap(Map map) {
    String type = map['type'];
    if (type == 'multichoice') {
      return new MultiChoiceQuestion.fromMap(map);
    } else if (type == 'writingshort'){
      throw "Unsupported question type: " + map['type'];
    }
  }
}

class MultiChoiceQuestion extends AbstractQuestion {
  int answer;
  List<String> options;
  int paragraph;
  
  MultiChoiceQuestion();
  
  factory MultiChoiceQuestion.fromMap(Map map) {
    MultiChoiceQuestion multiChoice = new MultiChoiceQuestion();
    multiChoice.answer = map['answer'];
    multiChoice.options = map['options'];
    multiChoice.paragraph = map['paragraph'];
    return multiChoice;
  }
}

/**
 * Speaking Q1 and Q2.
 */
class TopicSpeakingQuestion extends AbstractQuestion {
  String topic;
  String audio;
  
  TopicSpeakingQuestion();
  
  factory TopicSpeakingQuestion.fromMap(Map map) {
    TopicSpeakingQuestion topicSpeaking = new TopicSpeakingQuestion();
    topicSpeaking.topic = map['topic'];
    topicSpeaking.audio = map['audio'];
    return topicSpeaking;
  }
}

/**
 * Speaking Q3 and Q4.
 */
class OpinionSpeakingQuestion extends AbstractQuestion {
  String audio1;
  String passage;
  String audio2;
  String image;
  String question;
  String audio3;
  
  OpinionSpeakingQuestion();
  
  factory OpinionSpeakingQuestion.fromMap(Map map) {
    OpinionSpeakingQuestion opinionSpeaking = new OpinionSpeakingQuestion();
    opinionSpeaking.audio1 = map['audio1'];
    opinionSpeaking.passage = map['passage'];
    opinionSpeaking.audio2 = map['audio2'];
    opinionSpeaking.image = map['image'];
    opinionSpeaking.question = map['question'];
    opinionSpeaking.audio3 = map['audio3'];
    return opinionSpeaking;
  }
}

/**
 * Speaking Q5 and Q6
 */
class ListenSpeakingQuestion extends AbstractQuestion {
  String audio1;
  String image;
  String question;
  String audio2;
  
  ListenSpeakingQuestion();
  
  factory ListenSpeakingQuestion.fromMap(Map map) {
    ListenSpeakingQuestion listenSpeaking = new ListenSpeakingQuestion();
    listenSpeaking.audio1 = map['audio1'];
    listenSpeaking.image = map['image'];
    listenSpeaking.question = map['question'];
    listenSpeaking.audio2 = map['audio2'];
    return listenSpeaking;
  }
}

class WritingShortQuestion extends AbstractQuestion {
  String topic;
  String audio;
  String image;
  
  WritingShortQuestion();
  
  factory WritingShortQuestion.fromMap(Map map) {
    WritingShortQuestion writingShort = new WritingShortQuestion();
    writingShort.topic = map['topic'];
    writingShort.audio = map['audio'];
    writingShort.image = map['image'];
    return writingShort;
  }
}

class WritingLongQuestion extends AbstractQuestion {
  String question;
  
  WritingLongQuestion();
  
  factory WritingLongQuestion.fromMap(Map map) {
    WritingLongQuestion writingLong = new WritingLongQuestion();
    writingLong.question = map['question'];
    return writingLong;
  }
}