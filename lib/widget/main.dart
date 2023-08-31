import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test2/main2.dart';
import 'package:test2/widget/widget-all.dart';
import 'dart:core';

class tudo extends StatefulWidget {
  const tudo({
    super.key,
  });

  @override
  State<tudo> createState() => _tudo();
}

class _tudo extends State<tudo> {
  static const OPERATORS = ['∼', '∧', '⊻', '∨', '→', '↔'];
  String expression = " ";
  bool calcular = true;

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
      calcular = true;
    });
  }

  void clearExpression() {
    expression = " ";
  }

  void clearResult() {}

  String removeSpaces(String input) {
    return input.replaceAll(' ', '');
  }

  void backspace() {
    // Apaga o último valor digitado
    setState(() {
      if(calcular) {
        expression = expression.substring(0, expression.length - 1);
        if (expression == ""){
          expression == " "
        }
      }
    });
  }

  String correctExpression(String texto) {
    String expression = texto;
    expression += (expression.replaceAll(RegExp(r'[^\(]'), '').length >
            expression.replaceAll(RegExp(r'[^\)]'), '').length)
        ? ')'
        : '';

    while (RegExp(
            r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()')
        .hasMatch(expression)) {
      expression = expression.replaceAllMapped(
        RegExp(
            r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()'),
        (match) => '${match.group(1)}∧${match.group(2)}',
      );
    }

    return expression;
  }

  List<String> sortVariables(String texto) {
    List<String> array = [];
    for (String item in Set.from(texto
        .replaceAll("[Verdadeiro]", "1")
        .replaceAll("[Falso]", "0")
        .split(''))) {
      array.add(item);
    }

    return array.where((x) {
      int charCode = x.codeUnitAt(0);
      return charCode > 64 && charCode < 91;
    }).toList()
      ..sort();
  }

  Map<dynamic, dynamic> temp_array_answer_table = {};
  int temp_qtde_linhas_tabela = 0;

  void structureAnswer() {
    var variaveis = sortVariables(expression);
    int qtde_linhas_tabela = pow(2, variaveis.length).toInt();
    expression = correctExpression(expression);
    var array_answer_table = {};
    String bin = "0" * variaveis.length;
    for (int i = 0; i < qtde_linhas_tabela; i++) {
      Map<String, String> valores = {};
      for (int j = 0; j < variaveis.length; j++) {
        valores[variaveis[j]] = (bin[j] == '0') ? "1" : "0";

        if (array_answer_table[variaveis[j]] == null) {
          array_answer_table[variaveis[j]] = [];
        }
        array_answer_table[variaveis[j]]!.add((bin[j] == '0') ? "V" : "F");
      }

      var resposta = calculate_expression(expression, valores);
      for (var expressao in resposta[1].split('|')) {
        var exp = expressao.split(':');
        if (exp[0] != "" && !isRepeatedVar(exp[0], variaveis)) {
          if (array_answer_table[exp[0]] == null) {
            array_answer_table[exp[0]] = [];
          }
          array_answer_table[exp[0]]!.add((exp[1] == '1') ? "V" : "F");
        }
      }
      bin = addBinary(bin, "1");
    }

    temp_array_answer_table = array_answer_table;
    temp_qtde_linhas_tabela = qtde_linhas_tabela;
  }

  String addBinary(String a, String b) {
    var i = a.length - 1;
    var j = b.length - 1;
    var carry = 0;
    var result = "";

    while (i >= 0 || j >= 0) {
      var m = i < 0 ? 0 : int.parse(a[i]);
      var n = j < 0 ? 0 : int.parse(b[j]);
      carry += m + n;
      result = (carry % 2).toString() + result;
      carry = (carry / 2).toInt();
      i--;
      j--;
    }

    if (carry != 0) {
      result = carry.toString() + result;
    }

    return result;
  }

  String calculate_inner_expression(String exp) {
    while (RegExp(r'∼(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'∼(0|1)'), (match) {
        String? p = match.group(1);
        return (p == '0') ? '1' : '0';
      });
    }
    while (RegExp(r'(0|1)∧(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'(0|1)∧(0|1)'), (match) {
        String? p = match.group(1);
        String? q = match.group(2);
        return (p == '1' && q == '1') ? '1' : '0';
      });
    }
    while (RegExp(r'(0|1)⊻(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'(0|1)⊻(0|1)'), (match) {
        String? p = match.group(1);
        String? q = match.group(2);
        return ((p == '0' && q == '1') || (p == '1' && q == '0')) ? '1' : '0';
      });
    }
    while (RegExp(r'(0|1)∨(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'(0|1)∨(0|1)'), (match) {
        String? p = match.group(1);
        String? q = match.group(2);
        return (p == '1' || q == '1') ? '1' : '0';
      });
    }
    while (RegExp(r'(0|1)→(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'(0|1)→(0|1)'), (match) {
        String? p = match.group(1);
        String? q = match.group(2);
        return (p == '1' && q == '0') ? '0' : '1';
      });
    }
    while (RegExp(r'(0|1)↔(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'(0|1)↔(0|1)'), (match) {
        String? p = match.group(1);
        String? q = match.group(2);
        return ((p == '1' && q == '1') || (p == '0' && q == '0')) ? '1' : '0';
      });
    }
    return exp;
  }

  List<String> calculate_expression(String exp, Map<String, dynamic> obj, [String string_result = ""]) {
    int cont = 0;
    Map<String, dynamic> exp_dicio = {};
    String result = "(${exp})";
    while (result.contains(RegExp(r"\(([^\(\)]*)\)"))) {
      cont++;
      result = result.replaceAllMapped(RegExp(r"\(([^\(\)]*)\)"), (match) {
        exp_dicio["[P${cont}]"] = {};
        exp_dicio["[P${cont}]"]["exp"] = match.group(1);
        return "[P${cont}]";
      });
    }
    for (String inner_exp in exp_dicio.keys) {
      String raw_inner_exp = exp_dicio[inner_exp]["exp"];
      String modified_inner_exp = exp_dicio[inner_exp]["exp"];
      while (raw_inner_exp.contains(RegExp(r"(\[P\d+\])"))) {
        raw_inner_exp = raw_inner_exp.replaceAllMapped(RegExp(r"(\[P\d+\])"), (match) {
          return "(${exp_dicio[match.group(1)]["exp"]})";
        });
      }
      while (modified_inner_exp.contains(RegExp(r"(\[P\d+\])"))) {
        modified_inner_exp = modified_inner_exp.replaceAllMapped(RegExp(r"(\[P\d+\])"), (match) {
          return exp_dicio[match.group(1)]["value"];
        });
      }
      modified_inner_exp = modified_inner_exp.replaceAll("[Verdadeiro]", "1").replaceAll("[Falso]", "0");
      for (String variable in obj.keys) {
        modified_inner_exp = modified_inner_exp.replaceAll(variable, obj[variable].toString());
      }
      exp_dicio[inner_exp]["value"] = calculate_inner_expression(modified_inner_exp);
      string_result = "${string_result}|${raw_inner_exp}:${exp_dicio[inner_exp]["value"]}";
    }
    return [result, string_result];
  }

  bool isRepeatedVar(String str, List<String> array) {
    return array.contains(str);
  }

  var arrayElement = [];

  tableElements(Map<dynamic, dynamic> obj) {
    var arrayElement = [];
    if (obj.isNotEmpty) {
      var keys = obj.keys;
      for (var element in keys) {
        arrayElement.add(element);
      }
      this.arrayElement = arrayElement;
    }
  }

  // Função para converter um mapa genérico em uma lista de strings
  List<String> convertMapToArray(Map<dynamic, dynamic> inputMap) {
    List<String> resultArray = [];

    // Itera pelas chaves do mapa
    for (dynamic key in inputMap.keys) {
      // Adiciona a chave convertida para string ao resultado
      resultArray.add(key.toString());

      // Obtém a lista de valores correspondente à chave
      List<dynamic> valuesList = inputMap[key];

      // Converte cada valor para string e adiciona ao resultado
      resultArray.addAll(valuesList.map((value) => value.toString()));
    }

    return resultArray;
  }

// Função para converter um mapa genérico em um mapa de strings para strings
  Map<String, String> convertDynamicMapToStringMap(Map<dynamic, dynamic> dynamicMap) {
    Map<String, String> stringMap = {};

    // Itera por todas as chaves e valores do mapa dinâmico
    dynamicMap.forEach((key, value) {
      // Converte a chave e o valor para strings e adiciona ao novo mapa
      stringMap[key.toString()] = value.toString();
    });

    return stringMap;
  }

// Lista de strings vazia
  List<String> stringList = [];
  List<String> test = [];
// Variável booleana inicializada como falsa
  bool calculado = false;

// Função para separar elementos de uma lista com base em um intervalo específico
  List<String> separarElementos(List<String> lista) {
    List<String> listaElement = [];
    // Itera pelas posições da lista a partir de um ponto específico até o final
    for (int i = (lista.length - temp_qtde_linhas_tabela); i < lista.length; i++) {
      // Adiciona o elemento atual à nova lista
      listaElement.add(lista[i]);
    }
    return listaElement;
  }


// Função para verificar se uma lista contém apenas "F"s, indicando tautologia
  bool isTaltology(List<String> lista) {
    bool tautology = true;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] == "F") {
        tautology = false;
      }
    }
    return tautology;
  }

// Função para verificar se uma lista contém apenas "V"s, indicando contradição
  bool isContradiction(List<String> lista) {
    bool contradiction = true;
    for (int i = 0; i < lista.length; i++) {
      if (lista[i] == "V") {
        contradiction = false;
      }
    }
    return contradiction;
  }

// Função para verificar se uma lista contém tanto "V"s quanto "F"s, indicando contingência
  bool isContingency(List<String> lista) {
    int vCount = 0;
    int fCount = 0;

    for (var element in lista) {
      if (element == 'V') {
        vCount++;
      }
      if (element == 'F') {
        fCount++;
      }
      if (vCount > 0 && fCount > 0) {
        return true;
      }
    }
    return false;
  }

  void calculate() {
    setState(() {
      if (calcular) {
        calcular = false;
        structureAnswer();
        tableElements(temp_array_answer_table);
        stringList = convertMapToArray(temp_array_answer_table);
        print(temp_qtde_linhas_tabela);
        print(stringList);
        List<String> elementList = separarElementos(stringList);
        calculado = true;

        // limpar oque está sendo exibido na tela
        if (expression != " ") {
          clearExpression();
        }
        // exibir na tela oque a função é
        if (isTaltology(elementList)) {
          expression = "é uma tautologia";
          print("tautologia");
        } else if (isContradiction(elementList)) {
          expression = "é uma contradição";
          print("contradição");
        } else if (isContingency(elementList)) {
          expression = "é uma contingência";
          print("contingência");
        } else {
          expression = "error";
          print("error");
        }
      }
    });
  }

  void digito(String btnVal) {
    setState(() {
      if(calcular) {
        if (btnVal == '∼') {
          if (expression.endsWith('∼')) return;
        } else {
          if (isLogicalOperator(btnVal) &&
              isLogicalOperator(expression.substring(expression.length - 1)))
            return;
          if (isLogicalOperator(btnVal) &&
              expression.substring(expression.length - 1) == '') return;
        }
        if ((isVariable(btnVal) ||
            btnVal == '[Verdadeiro]' ||
            btnVal == '[Falso]') &&
            (isVariable(expression.substring(expression.length - 1)) ||
                RegExp(r'\[(?:Verdadeiro|Falso)\]$').hasMatch(expression))) {
          return;
        }

        if (btnVal == '(' &&
            isVariable(expression.substring(expression.length - 1))) {
          return;
        }
        if (btnVal == ')' &&
            (expression
                .replaceAll(RegExp(r'[^\(]'), '')
                .length <=
                expression
                    .replaceAll(RegExp(r'[^\)]'), '')
                    .length)) {
          return;
        }
        if (btnVal == ')' && expression.endsWith("(")) {
          return;
        }

        expression += btnVal;
        expression = removeSpaces(expression);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    if(calculado){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => table(arrayElement: stringList, tamanhoTabela: temp_qtde_linhas_tabela + 1,
                                )));
                    } else {
                      null;
                    }
                  },
                  icon: Icon(Icons.table_rows),
                  label: Text("Tabela verdade")),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: MaterialApp(
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
                  //borderRadius: BorderRadius.circular(15),
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
                  constraints: const BoxConstraints(
                      minWidth: 100,
                      maxWidth: 562,
                      minHeight: 100,
                      maxHeight: 667),
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
                      ),
                      BoxShadow(
                        color: Color(0x42000000),
                        blurRadius: 30,
                        offset: Offset(0, 30),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 41,
                        offset: Offset(0, 68),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 48,
                        offset: Offset(0, 120),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x02000000),
                        blurRadius: 52,
                        offset: Offset(0, 188),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
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
                            screen(
                              calculo: expression,
                            ),
                            button_calculator(
                              text: 'A',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'B',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'C',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'D',
                              callback: digito,
                            ),
                            button_specialy(
                              text: 'C',
                              callback: clearScreen,
                            ),
                            button_specialy2(
                              callback: backspace,
                            ),
                            button_calculator(
                              text: 'E',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'F',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'G',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'H',
                              callback: digito,
                            ),
                            button_specialy3(
                              text: "(",
                              callback: digito,
                            ),
                            button_specialy3(
                              text: ")",
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'I',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'J',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'K',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'L',
                              callback: digito,
                            ),
                            button_specialy4(
                              callback: digito,
                            ),
                            button_specialy5(
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'M',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'N',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'O',
                              callback: digito,
                            ),
                            button_calculator(
                              text: 'P',
                              callback: digito,
                            ),
                            button_specialy6(
                              callback: digito,
                            ),
                            button_specialy7(
                              callback: digito,
                            ),
                            Wrap(
                              children: [
                                Container(
                                  width: 380,
                                  height: 216,
                                  child: Wrap(
                                    children: [
                                      button_calculator(
                                        text: 'Q',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'R',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'S',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'T',
                                        callback: digito,
                                      ),
                                      button_specialy8(
                                        text: '∼',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'U',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'V',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'W',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'X',
                                        callback: digito,
                                      ),
                                      button_specialy10(
                                        text: 'V',
                                        callback: digito,
                                      ),
                                      button_invisible(),
                                      button_calculator(
                                        text: 'Y',
                                        callback: digito,
                                      ),
                                      button_calculator(
                                        text: 'Z',
                                        callback: digito,
                                      ),
                                      button_invisible(),
                                      button_specialy11(
                                        text: 'F',
                                        callback: digito,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 76,
                                  height: 216,
                                  child: Wrap(
                                    children: [
                                      button_specialy9(
                                        text: '=',
                                        callback: calculate,
                                      ),
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
        ));
  }
}
