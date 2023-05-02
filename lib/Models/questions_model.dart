class QuestionsModel {
  final String? question;
  final String? heading;
  final List<AnswerModel>? answers;

  QuestionsModel({this.question, this.heading, this.answers});
}

class AnswerModel {
  final String? text;
  bool? isSelected;
  AnswerModel({this.text, this.isSelected});
}
