import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  List? questions;
  int currentQuestionCount = 0;
  final int maxQuestions = 10;
  final String difficultyLevel;
  int correctCount = 0;
  BuildContext context;

  GamePageProvider({required this.context, required this.difficultyLevel}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    getQuestionsFromAPI();
  }

  Future<void> getQuestionsFromAPI() async {
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficultyLevel,
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![currentQuestionCount]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![currentQuestionCount]['correct_answer'] == answer;
    correctCount += isCorrect ? 1 : 0;
    currentQuestionCount++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (currentQuestionCount == maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'End Game!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.blue,
          content: Text('Score: $correctCount/$maxQuestions'),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
