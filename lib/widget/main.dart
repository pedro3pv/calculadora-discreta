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

  String addBinary(String a, String b) {
    int i = a.length - 1;
    int j = b.length - 1;
    int carry = 0;
    String result = "";

    while (i >= 0 || j >= 0) {
      int m = i < 0 ? 0 : int.parse(a[i]) | 0;
      int n = j < 0 ? 0 : int.parse(b[j]) | 0;
      carry += m + n; // soma de dois dígitos
      result = (carry % 2).toString() + result; // concatena a string
      carry = (carry / 2).toInt(); // remove os decimais, 1 / 2 = 0.5, pega apenas o 0
      i--;
      j--;
    }
    if (carry != 0) {
      result = carry.toString() + result;
    }
    return result;
  }

  String correctExpression(String texto) {
    final openParenthesesCount = expression.replaceAll(RegExp(r'[^\(]'), '').length;
    final closeParenthesesCount = expression.replaceAll(RegExp(r'[^\)]'), '').length;
    final additionalCloseParentheses = List.generate(
        openParenthesesCount - closeParenthesesCount, (_) => ')').join('');

    texto = '$texto$additionalCloseParentheses';

    while (RegExp(r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()').hasMatch(texto)) {
      texto = texto.replaceAllMapped(
        RegExp(r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()', multiLine: true),
            (match) {
          return '${match.group(1)}∧${match.group(2)}';
        },
      );
    }

    return texto;
  }


  List<String> sortVariables(String texto) {
    Set<String> array = {};
    for (var item in texto.replaceAll("[Verdadeiro]", "1").replaceAll("[Falso]", "0").split("")) {
      array.add(item);
    }

    return array.where((x) {
      return x.codeUnitAt(0) > 64 && x.codeUnitAt(0) < 91;
    }).toList()
      ..sort();
  }

  Map<String, dynamic> calculateExpression(String exp, Map<String, String> obj, [String stringResult = ""]) {
    int cont = 0;
    Map<String, dynamic> expDicio = {};
    String result = "($exp)";

    while (RegExp(r'\(([^\(\)]*)\)').hasMatch(result)) {
      cont++;
      result = result.replaceFirstMapped(RegExp(r'\(([^\(\)]*)\)'), (match) {
        expDicio['[P$cont'] = {'exp': match.group(1)};
        return '[P$cont]';
      });
    }

    // Aqui, você precisará continuar a implementação da lógica para calcular a expressão,
    // usando o objeto "obj" para substituir as variáveis e os valores correspondentes,
    // e também utilizando o mapa "expDicio" para calcular os resultados das expressões entre parênteses.

    // No final, retorne um mapa contendo as informações necessárias.
    return {
      'expression': exp,
      'result': stringResult, // Defina aqui o resultado da expressão calculada
    };
  }

  bool isRepeatedVar(String str, List<String> array) {
    for (var v in array) {
      if (str == v) return true;
    }
    return false;
  }

  List<String> expressionToArray(List<List<String>> tableData) {
    List<String> array = [];

    for (List<String> row in tableData) {
      String lastCell = row.last;
      array.add(lastCell);
    }

    return array;
  }


  void structureAnswer() {
    // Estrutura a resposta
    expression = correctExpression(expression);
    List<String> variaveis = sortVariables(expression);
    int qtdeLinhasTabela = (1 << variaveis.length);
    String bin = "0" * variaveis.length; // Cria uma string com o valor 0 em binário
    Map<String, List<String>> arrayAnswerTable = {};

    for (int i = 0; i < qtdeLinhasTabela; i++) {
      Map<String, String> valores = {};
      for (int j = 0; j < variaveis.length; j++) {
        valores[variaveis[j]] = (bin[j] == '0') ? "1" : "0";

        if (arrayAnswerTable[variaveis[j]] == null) {
          arrayAnswerTable[variaveis[j]] = [];
        }
        arrayAnswerTable[variaveis[j]]!.add((bin[j] == '0') ? "V" : "F");
      }

      var resposta = calculateExpression(expression, valores);
      for (var expressao in resposta[1].split('|')) {
        var exp = expressao.split(':');
        if (exp[0] != "" && !isRepeatedVar(exp[0], variaveis)) {
          if (arrayAnswerTable[exp[0]] == null) {
            arrayAnswerTable[exp[0]] = [];
          }
          arrayAnswerTable[exp[0]]!.add((exp[1] == '1') ? "V" : "F");
        }
      }
      bin = addBinary(bin, "1"); // Adiciona 1 ao valor binário
    }

    List<String> expressionResultArray = expressionToArray();

    // Aqui, você precisará usar a abordagem apropriada para atualizar a interface do seu aplicativo Flutter
    // com os resultados calculados. Não é possível fornecer um código exato sem mais contexto sobre a estrutura do seu aplicativo.
  }

  void calculate() {
    setState(() {
      // Calcula o resultado
      if (expression != " ") {
        structureAnswer();
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
      removeSpaces(expression);
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