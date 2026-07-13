import '../utils/html_unescape.dart';

class Question {
  final String question;
  final String correctAnswer;
  final List<String> options;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final cleanCorrectAnswer = HtmlUnescape.unescape(json["correct_answer"]?.toString() ?? "");
    
    List<String> answers = [cleanCorrectAnswer];

    if (json["incorrect_answers"] != null) {
      answers.addAll(
        (json["incorrect_answers"] as List).map((e) => HtmlUnescape.unescape(e.toString())),
      );
    }

    answers.shuffle();

    return Question(
      question: HtmlUnescape.unescape(json["question"]?.toString() ?? ""),
      correctAnswer: cleanCorrectAnswer,
      options: answers,
    );
  }
}