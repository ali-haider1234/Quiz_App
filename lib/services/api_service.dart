import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static const String apiUrl =
      "https://opentdb.com/api.php?amount=10&type=multiple";

  static Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(
        const Duration(seconds: 8),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["response_code"] == 0 && data["results"] != null) {
          List results = data["results"];
          return results.map((json) => Question.fromJson(json)).toList();
        }
      }
    } catch (_) {
      // Fallback to high quality offline questions if API is unreachable or rate limited
    }
    return _getFallbackQuestions();
  }

  static List<Question> _getFallbackQuestions() {
    final rawData = [
      {
        "question": "What is the capital city of Australia?",
        "correct_answer": "Canberra",
        "incorrect_answers": ["Sydney", "Melbourne", "Brisbane"]
      },
      {
        "question": "Which planet is known as the Red Planet?",
        "correct_answer": "Mars",
        "incorrect_answers": ["Venus", "Jupiter", "Saturn"]
      },
      {
        "question": "Who wrote the play &quot;Romeo and Juliet&quot;?",
        "correct_answer": "William Shakespeare",
        "incorrect_answers": ["Charles Dickens", "Mark Twain", "Jane Austen"]
      },
      {
        "question": "What is the chemical symbol for Gold?",
        "correct_answer": "Au",
        "incorrect_answers": ["Ag", "Fe", "Gd"]
      },
      {
        "question": "In what year did the first manned moon landing occur?",
        "correct_answer": "1969",
        "incorrect_answers": ["1965", "1972", "1959"]
      },
      {
        "question": "Which ocean is the largest on Earth?",
        "correct_answer": "Pacific Ocean",
        "incorrect_answers": ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean"]
      },
      {
        "question": "What is the hardest natural substance on Earth?",
        "correct_answer": "Diamond",
        "incorrect_answers": ["Graphene", "Platinum", "Quartz"]
      },
      {
        "question": "Which country invented tea?",
        "correct_answer": "China",
        "incorrect_answers": ["India", "United Kingdom", "Japan"]
      },
      {
        "question": "How many hearts does an octopus have?",
        "correct_answer": "Three",
        "incorrect_answers": ["One", "Two", "Four"]
      },
      {
        "question": "Who painted the Mona Lisa?",
        "correct_answer": "Leonardo da Vinci",
        "incorrect_answers": ["Vincent van Gogh", "Pablo Picasso", "Michelangelo"]
      }
    ];

    return rawData.map((json) => Question.fromJson(json)).toList();
  }
}