import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test2/widget/widget-all.dart';
import 'dart:core';

class tudo extends StatefulWidget {

  const tudo({
    super.key,
  });

  @override
  State<tudo> createState() => _tudo();
}

class _tudo extends State<tudo>{

  static const OPERATORS = ['∼','∧','⊻','∨','→','↔'];
  String expression = " ";

  bool evaluateExpression(String expression, Map<String, bool> values) {
    expression = expression.replaceAll('→', '=>').replaceAll('¬', '!');

    for (var variable in values.keys) {
      expression = expression.replaceAll(variable, values[variable].toString());
    }

    return Function.apply(logicalExpression, [expression]);
  }

  bool logicalExpression(String expression) => logicalEval(expression);

  bool logicalEval(String expression) {
    final tokens = expression.split('');
    final stack = <bool>[];

    for (var token in tokens) {
      if (token == 'T') {
        stack.add(true);
      } else if (token == 'F') {
        stack.add(false);
      } else if (token == '!') {
        final operand = stack.removeLast();
        stack.add(!operand);
      } else if (token == '&') {
        final operand2 = stack.removeLast();
        final operand1 = stack.removeLast();
        stack.add(operand1 && operand2);
      } else if (token == '|') {
        final operand2 = stack.removeLast();
        final operand1 = stack.removeLast();
        stack.add(operand1 || operand2);
      } else if (token == '=>') {
        final operand2 = stack.removeLast();
        final operand1 = stack.removeLast();
        stack.add(!operand1 || operand2);
      }
    }

    return stack.isNotEmpty ? stack.first : false;
  }


  List<String> _extractVariables(String expression) {
    final uniqueVariables = expression.split('').where((char) => char != '(' && char != ')' && char != '&' && char != '|' && char != '!' && char != 'T' && char != 'F' && char != '=').toSet();
    return uniqueVariables.toList();
  }

  List<Map<String, bool>> _generateTruthValues(List<String> variables) {
    final truthValues = <Map<String, bool>>[];
    final count = variables.length;

    for (var i = 0; i < (1 << count); i++) {
      final values = <String, bool>{};

      for (var j = 0; j < count; j++) {
        values[variables[j]] = ((i >> j) & 1) == 1;
      }

      truthValues.add(values);
    }

    return truthValues;
  }


  bool isVariable(String btnVal) {
    if (btnVal.codeUnitAt(0) > 64 && btnVal.codeUnitAt(0) < 91) {
      return true;
    }
    return false;
  }

  bool isLogicalOperator(String btnVal) {
    for (String element in OPERATORS) {
      if (btnVal == element) return true;
    }
    return false;
  }

  void clearScreen() {
    setState(() {
      // Limpa a expressão
      print("clear");
      if (expression != " ") {
        clearExpression();
      } else {
        clearResult();
      }
    });
  }

  void clearExpression() {
    expression = " ";
  }

  void clearResult() {

  }

  String removeSpaces(String input) {
    return input.replaceAll(' ', '');
  }

  void backspace() {
    // Apaga o último valor digitado
    setState(() {
      expression = expression.substring(0, expression.length - 1);
    });
  }

  String correctExpression(String texto) {
    String expression = texto;
    expression +=
    (expression.replaceAll(RegExp(r'[^\(]'), '').length >
        expression.replaceAll(RegExp(r'[^\)]'), '').length)
        ? ')'
        : '';

    while (RegExp(r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()')
        .hasMatch(expression)) {
      expression = expression.replaceAllMapped(
        RegExp(r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()'),
            (match) => '${match.group(1)}∧${match.group(2)}',
      );
    }

    return expression;
  }

  List<String> sortVariables(String texto) {
    List<String> array = [];
    for (String item in Set.from(texto.replaceAll("[Verdadeiro]", "1").replaceAll("[Falso]", "0").split(''))) {
      array.add(item);
    }

    return array.where((x) {
      int charCode = x.codeUnitAt(0);
      return charCode > 64 && charCode < 91;
    }).toList()
      ..sort();
  }

  void structureAnswer(){
    expression = correctExpression(expression);
    print(expression);
    var variaveis = sortVariables(expression);
    int qtde_linhas_tabela = pow(2, variaveis.length).toInt();
    String bin = "0" * variaveis.length;
    var array_answer_table = {};
    print(bin);
  }

  void calculate() {
    setState(() {
      structureAnswer();
      // Calcula o resultado
      if (expression != " ") {

        clearExpression();
      }
    });
  }


  void digito(String btnVal){
    setState(() {

      print(btnVal);
      if (btnVal == '∼') {
        if (expression.endsWith('∼')) return;
      } else {
        if (isLogicalOperator(btnVal) && isLogicalOperator(expression.substring(expression.length - 1))) return;
        if (isLogicalOperator(btnVal) && expression.substring(expression.length - 1) == '') return;
      }
      if ((isVariable(btnVal) || btnVal == '[Verdadeiro]' || btnVal == '[Falso]') &&
          (isVariable(expression.substring(expression.length - 1)) || RegExp(r'\[(?:Verdadeiro|Falso)\]$').hasMatch(expression))) {
        return;
      }

      if (btnVal == '(' && isVariable(expression.substring(expression.length - 1))) {
        return;
      }
      if (btnVal == ')' &&
          (expression.replaceAll(RegExp(r'[^\(]'), '').length <= expression.replaceAll(RegExp(r'[^\)]'), '').length)) {
        return;
      }
      if (btnVal == ')' && expression.endsWith("(")) {
        return;
      }

      expression += btnVal;
      expression = removeSpaces(expression);
    });
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Discreta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF7F7ECE), Color(0xFF8E7ECE)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 53,
                right: 53,
                bottom: 12,
              ),
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 562,minHeight: 100,maxHeight: 667),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF2D2A37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x49000000),
                    blurRadius: 17,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                  ),BoxShadow(
                    color: Color(0x42000000),
                    blurRadius: 30,
                    offset: Offset(0, 30),
                    spreadRadius: 0,
                  ),BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 41,
                    offset: Offset(0, 68),
                    spreadRadius: 0,
                  ),BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 48,
                    offset: Offset(0, 120),
                    spreadRadius: 0,
                  ),BoxShadow(
                    color: Color(0x02000000),
                    blurRadius: 52,
                    offset: Offset(0, 188),
                    spreadRadius: 0,
                  ),BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    child: Wrap(
                      children: [
                        screen(calculo: expression,),
                        button_calculator(text: 'A',callback: digito,),
                        button_calculator(text: 'B',callback: digito,),
                        button_calculator(text: 'C',callback: digito,),
                        button_calculator(text: 'D',callback: digito,),
                        button_specialy(text: 'C',callback: clearScreen,),
                        button_specialy2(callback: backspace,),
                        button_calculator(text: 'E',callback: digito,),
                        button_calculator(text: 'F',callback: digito,),
                        button_calculator(text: 'G',callback: digito,),
                        button_calculator(text: 'H',callback: digito,),
                        button_specialy3(text: "(",callback: digito,),
                        button_specialy3(text: ")",callback: digito,),
                        button_calculator(text: 'I',callback: digito,),
                        button_calculator(text: 'J',callback: digito,),
                        button_calculator(text: 'K',callback: digito,),
                        button_calculator(text: 'L',callback: digito,),
                        button_specialy4(callback: digito,),
                        button_specialy5(callback: digito,),
                        button_calculator(text: 'M',callback: digito,),
                        button_calculator(text: 'N',callback: digito,),
                        button_calculator(text: 'O',callback: digito,),
                        button_calculator(text: 'P',callback: digito,),
                        button_specialy6(callback: digito,),
                        button_specialy7(callback: digito,),
                        Wrap(
                          children: [
                          Container(
                          width: 380,
                          height: 216,
                          child: Wrap(
                            children: [
                              button_calculator(text: 'Q',callback: digito,),
                              button_calculator(text: 'R',callback: digito,),
                              button_calculator(text: 'S',callback: digito,),
                              button_calculator(text: 'T',callback: digito,),
                              button_specialy8(text: '~',callback: digito,),
                              button_calculator(text: 'U',callback: digito,),
                              button_calculator(text: 'V',callback: digito,),
                              button_calculator(text: 'W',callback: digito,),
                              button_calculator(text: 'X',callback: digito,),
                              button_specialy10(text: 'V', callback: digito,),
                              button_invisible(),
                              button_calculator(text: 'Y',callback: digito,),
                              button_calculator(text: 'Z',callback: digito,),
                              button_invisible(),
                              button_specialy11(text: 'F', callback: digito,),
                            ],
                          ),
                        ),
                    Container(
                      width: 76,
                      height: 216,
                      child: Wrap(
                        children: [
                          button_specialy9(text: '=', callback: calculate,),
                        ],
                        ),
                    ),
                      ],
                    ),
        ],
                  ),
    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}