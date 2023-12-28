import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzify/model/questions_model.dart';

class QuestionsNotifier extends ChangeNotifier {
  QuestionModel _questions = QuestionModel();
  QuestionModel get questions => _questions;

  Future<void> getQuestions(bool notify) async {
    final String data = await rootBundle.loadString('assets/Questions.json');
    final response = await json.decode(data);
    _questions = QuestionModel.fromJson(response);

    notifyListeners();
  }
}
