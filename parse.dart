// To parse this JSON data, do
//
//     final jsonParser = jsonParserFromJson(jsonString);

import 'dart:convert';

List<JsonParser> jsonParserFromJson(String str) =>
    List<JsonParser>.from(json.decode(str).map((x) => JsonParser.fromJson(x)));

String jsonParserToJson(List<JsonParser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonParser {
  JsonParser({
    //required this.instructions,
    // required this.metadata,
    // required this.questionId,
    required this.data,
    //required this.solution,
    // required this.attachment,
    // required this.solutionStrategies,
    // required this.style,
    // required this.type,
    // required this.widgetType,
  });

  //String instructions;
  // JsonParserMetadata metadata;
  // String questionId;
  Data data;
  // JsonParserSolution solution;
  // String attachment;
  // String solutionStrategies;
  // Style style;
  // String type;
  // String widgetType;

  factory JsonParser.fromJson(Map<String, dynamic> json) => JsonParser(
        //instructions: json["instructions"],
        // metadata: JsonParserMetadata.fromJson(json["metadata"]),
        // questionId: json["questionID"],
        data: Data.fromJson(json["data"]),
        // solution: JsonParserSolution.fromJson(json["solution"]),
        // attachment: json["attachment"],
        // solutionStrategies: json["solutionStrategies"],
        // style: Style.fromJson(json["style"]),
        // type: json["type"],
        // widgetType: json["widget_type"],
      );

  Map<String, dynamic> toJson() => {
        //"instructions": instructions,
        //"metadata": metadata.toJson(),
        // "questionID": questionId,
        "data": data.toJson(),
        // "solution": solution.toJson(),
        // "attachment": attachment,
        // "solutionStrategies": solutionStrategies,
        // "style": style.toJson(),
        // "type": type,
        // "widget_type": widgetType,
      };
}

class Data {
  Data({
    //required this.stimulusMedia,
    //required this.metadata,
    required this.solution,
    required this.stimulus,
    required this.options,
    //required this.style,
    //required this.marks,
    //required this.type,
  });

  //String stimulusMedia;
  //DataMetadata metadata;
  StyleClass solution;
  String stimulus;
  List<Option> options;
  //StyleClass style;
  //int marks;
  // String type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        //stimulusMedia: json["stimulus_media"],
        // metadata: DataMetadata.fromJson(json["metadata"]),
        solution: StyleClass.fromJson(json["solution"]),
        stimulus: json["stimulus"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        // style: StyleClass.fromJson(json["style"]),
        // marks: json["marks"],
        // type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        // "stimulus_media": stimulusMedia,
        // "metadata": metadata.toJson(),
        "solution": solution.toJson(),
        "stimulus": stimulus,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        //  "style": style.toJson(),
        //  "marks": marks,
        // "type": type,
      };
}

class DataMetadata {
  DataMetadata({
    required this.duration,
    required this.difficulty,
    required this.distractorRationale,
    required this.bloom,
    required this.acknowledgements,
    required this.construct,
    required this.shuffle,
    required this.version,
    required this.microConcept,
  });

  int duration;
  String difficulty;
  Acknowledgements distractorRationale;
  String bloom;
  Acknowledgements acknowledgements;
  String construct;
  bool shuffle;
  int version;
  List<MicroConcept> microConcept;

  factory DataMetadata.fromJson(Map<String, dynamic> json) => DataMetadata(
        duration: json["duration"],
        difficulty: json["difficulty"],
        distractorRationale:
            Acknowledgements.fromJson(json["distractor_rationale"]),
        bloom: json["bloom"],
        acknowledgements: Acknowledgements.fromJson(json["acknowledgements"]),
        construct: json["construct"],
        shuffle: json["shuffle"],
        version: json["version"],
        microConcept: List<MicroConcept>.from(
            json["microConcept"].map((x) => MicroConcept.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "difficulty": difficulty,
        "distractor_rationale": distractorRationale.toJson(),
        "bloom": bloom,
        "acknowledgements": acknowledgements.toJson(),
        "construct": construct,
        "shuffle": shuffle,
        "version": version,
        "microConcept": List<dynamic>.from(microConcept.map((x) => x.toJson())),
      };
}

class Acknowledgements {
  Acknowledgements({
    required this.label,
    required this.audio,
  });

  String label;
  String audio;

  factory Acknowledgements.fromJson(Map<String, dynamic> json) =>
      Acknowledgements(
        label: json["label"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "audio": audio,
      };
}

class MicroConcept {
  MicroConcept({
    required this.id,
    required this.label,
  });

  String id;
  String label;

  factory MicroConcept.fromJson(Map<String, dynamic> json) => MicroConcept(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}

class Option {
  Option({
    required this.feedback,
    required this.score,
    required this.label,
    this.media,
    required this.value,
    required this.isCorrect,
  });

  List<Feedback> feedback;
  int score;
  String label;
  dynamic media;
  int value;
  int isCorrect;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        feedback: List<Feedback>.from(
            json["feedback"].map((x) => Feedback.fromJson(x))),
        score: json["score"],
        label: json["label"],
        media: json["media"],
        value: json["value"],
        isCorrect: json["isCorrect"],
      );

  Map<String, dynamic> toJson() => {
        "feedback": List<dynamic>.from(feedback.map((x) => x.toJson())),
        "score": score,
        "label": label,
        "media": media,
        "value": value,
        "isCorrect": isCorrect,
      };
}

class Feedback {
  Feedback({
    required this.text,
    this.media,
  });

  String text;
  dynamic media;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        text: json["text"],
        media: json["media"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "media": media,
      };
}

class StyleClass {
  StyleClass();

  factory StyleClass.fromJson(Map<String, dynamic> json) => StyleClass();

  Map<String, dynamic> toJson() => {};
}

class JsonParserMetadata {
  JsonParserMetadata({
    required this.templateReference,
    required this.name,
  });

  String templateReference;
  String name;

  factory JsonParserMetadata.fromJson(Map<String, dynamic> json) =>
      JsonParserMetadata(
        templateReference: json["template_reference"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "template_reference": templateReference,
        "name": name,
      };
}

class JsonParserSolution {
  JsonParserSolution({
    required this.data,
    required this.answer,
    required this.stepNav,
    required this.type,
  });

  List<dynamic> data;
  String answer;
  bool stepNav;
  String type;

  factory JsonParserSolution.fromJson(Map<String, dynamic> json) =>
      JsonParserSolution(
        data: List<dynamic>.from(json["data"].map((x) => x)),
        answer: json["answer"],
        stepNav: json["step_nav"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
        "answer": answer,
        "step_nav": stepNav,
        "type": type,
      };
}

class Style {
  Style({
    required this.qStyle,
    required this.userInteraction,
  });

  QStyle qStyle;
  UserInteraction userInteraction;

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        qStyle: QStyle.fromJson(json["qStyle"]),
        userInteraction: UserInteraction.fromJson(json["userInteraction"]),
      );

  Map<String, dynamic> toJson() => {
        "qStyle": qStyle.toJson(),
        "userInteraction": userInteraction.toJson(),
      };
}

class QStyle {
  QStyle({
    required this.bg,
  });

  String bg;

  factory QStyle.fromJson(Map<String, dynamic> json) => QStyle(
        bg: json["bg"],
      );

  Map<String, dynamic> toJson() => {
        "bg": bg,
      };
}

class UserInteraction {
  UserInteraction({
    required this.stylePrint,
    required this.stylePreview,
    required this.styleReview,
    required this.styleAttempt,
  });

  String stylePrint;
  String stylePreview;
  String styleReview;
  String styleAttempt;

  factory UserInteraction.fromJson(Map<String, dynamic> json) =>
      UserInteraction(
        stylePrint: json["stylePrint"],
        stylePreview: json["stylePreview"],
        styleReview: json["styleReview"],
        styleAttempt: json["styleAttempt"],
      );

  Map<String, dynamic> toJson() => {
        "stylePrint": stylePrint,
        "stylePreview": stylePreview,
        "styleReview": styleReview,
        "styleAttempt": styleAttempt,
      };
}
