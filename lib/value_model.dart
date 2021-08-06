import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcValueNotifier extends ChangeNotifier {
  var userInput = '';
  var answer = '';

  Future<void> valuePressed(value) async {
    userInput += value;
    notifyListeners();
  }

  Future<void> clearPressed() async {
    userInput = '';
    answer = '0';
    notifyListeners();
  }

  Future<void> deletePressed() async {
    userInput = userInput.substring(0, userInput.length - 1);
    notifyListeners();
  }

// function to calculate the input operation
  Future<void> equalPressed() async {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    notifyListeners();
  }
}