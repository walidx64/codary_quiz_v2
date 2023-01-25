import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz_codary_v1/models/question_model.dart';
import 'package:quiz_codary_v1/screens/result_screen/result_screen.dart';
import 'package:quiz_codary_v1/screens/welcome_screen.dart';

class QuizController extends GetxController{
  String name = '';
 //Name of the user taking the quiz.
  int get countOfQuestion => _questionsList.length;
  //Number questions in the list

  //Questions and options of the quiz as a list of QuestionModel objects
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
          "What is the target market for Codary?",
      answer: 0,
      options: ['Children between 7 and 16 years', 'Adults over 18 years', 'Elderly people over 60 years', 'All age groups'],
    ),
    QuestionModel(
      id: 2,
      question: "What is the unique value proposition of Codary?",
      answer: 1,
      options: ['Self-paced learning', 'Cohort-based learning', 'Short-term learning', 'In-person classes'],
    ),
    QuestionModel(
      id: 3,
      question: "What is the goal of Codary for annual recurring revenue by 2026?",
      answer: 2,
      options: ['60k', '1.2M', '100M', '5M'],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];
  //copy of the list to expose to public


  bool _isPressed = false;
  //check if an answer is pressed.
  bool get isPressed => _isPressed;


  double _numberOfQuestion = 1;
  //the current number of question.
  double get numberOfQuestion => _numberOfQuestion;


  int? _selectAnswer;
  //the selected answer of the user.
  int? get selectAnswer => _selectAnswer;


  int? _correctAnswer;
  //the correct answer of the current question.

  int _countOfCorrectAnswers = 0;
  //the number of correct answers.
  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  final Map<int, bool> _questionIsAnswerd = {};
  //map of questions and whether they have been answered or not.

  late PageController pageController;
  //control the pages of the quiz

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers + 0;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }
  //This method is used to check if the selected answer is correct.
  //It updates the _isPressed, _selectAnswer, _correctAnswer, and _countOfCorrectAnswers fields
  //and calls the nextQuestion() method after a delay.

  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }
  //check if a specific question has been answered or not.

  void nextQuestion() {
    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }
  //next question of the quiz or
  //the result screen if it is the last question.

  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }
  //get the color of the selected answer based on
  //whether it is correct or incorrect.

  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }
  //right and wrong icon

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
  //  Restart the quiz

  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }
  //Reset the answers of the quiz when the user wants to start again.

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  }


