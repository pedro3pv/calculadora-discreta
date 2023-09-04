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

  bool isVariable(String btnVal) { //verifica se o primeiro caractere da string é uma letra maiúscula.
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
      if (calcular) {
        if (expression.length > 1) {
          expression = expression.substring(1, expression.length - 1);
        } else {
          expression = " ";
        }
      }
    });
  }

  String correctExpression(String texto) {
    String expression = texto; //Cria uma nova string chamada expression com o mesmo conteúdo da string de entrada texto.
    //O código a seguir verifica se há mais parênteses de abertura ( do que parênteses de fechamento ).
    // Se isso for verdade, adiciona um parêntese de fechamento ) ao final da expressão. Isso ajuda a garantir que a expressão tenha parênteses correspondentes.
    expression += (expression.replaceAll(RegExp(r'[^\(]'), '').length >
            expression.replaceAll(RegExp(r'[^\)]'), '').length)
        ? ')'
        : '';

    //O loop while verifica se há variáveis ou operadores adjacentes na expressão (por exemplo, "AB", "A∼", "B1") e, se encontrar, substitui-os inserindo um
    // operador de conjunção (∧) entre eles. Isso garante que a expressão esteja bem formada e que todos os operadores necessários estejam presentes.

    while (RegExp(
            r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()')
        .hasMatch(expression)) {
      expression = expression.replaceAllMapped(
        RegExp(
            r'([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|\))([A-Z]|\[Verdadeiro\]|\[Falso\]|0|1|∼|\()'),
        (match) => '${match.group(1)}∧${match.group(2)}',
      );
    }

    return expression;//Retorna a expressão corrigida após todas as correções terem sido aplicadas.
  }

  List<String> sortVariables(String texto) {
    //List<String> array = [];: Inicializa uma lista vazia chamada array que será usada para armazenar as variáveis encontradas na expressão.
    List<String> array = [];
    for (String item in Set.from(texto//Itera pelos caracteres únicos resultantes da divisão anterior (elimina duplicatas) e adiciona cada caractere à lista array.
        .replaceAll("[Verdadeiro]", "1")//texto.replaceAll("[Verdadeiro]", "1") substitui todas as ocorrências de "[Verdadeiro]" por "1" na expressão.
        .replaceAll("[Falso]", "0")//texto.replaceAll("[Falso]", "0") substitui todas as ocorrências de "[Falso]" por "0" na expressão.
        .split(''))) {//.split('') divide a expressão em uma lista de caracteres.
      array.add(item);
    }

    //O código a seguir filtra a lista array para manter apenas os caracteres que são letras maiúsculas (variáveis) usando array.where(...). O critério de filtro
    // é determinado pelo valor numérico do código Unicode de cada caractere. Caracteres maiúsculos em Unicode têm valores de código de 65 (A) a 90 (Z).

    return array.where((x) {
      int charCode = x.codeUnitAt(0);
      return charCode > 64 && charCode < 91;//A função retorna a lista classificada de variáveis encontradas na expressão.
    }).toList()//.toList(): Converte o resultado do filtro em uma lista.
      ..sort();//..sort(): Classifica a lista resultante em ordem alfabética.
  }

  Map<dynamic, dynamic> temp_array_answer_table = {};
  int temp_qtde_linhas_tabela = 0;

  //Essa função é responsável por criar uma tabela de respostas para uma expressão lógica,
  // gerando todas as combinações possíveis de valores para as variáveis presentes na expressão e calculando o resultado da expressão para cada combinação.

  void structureAnswer() {
    //Ela começa obtendo a lista de variáveis presentes na expressão
    // através da função sortVariables e calcula a quantidade de linhas necessárias na tabela usando a fórmula 2^numero_de_variaveis.
    var variaveis = sortVariables(expression);
    int qtde_linhas_tabela = pow(2, variaveis.length).toInt();
    //A expressão é corrigida com a função correctExpression.
    expression = correctExpression(expression);
    var array_answer_table = {};
    String bin = "0" * variaveis.length;
    //Um loop for gera todas as combinações binárias possíveis para as variáveis, armazenando essas combinações no mapa valores.
    for (int i = 0; i < qtde_linhas_tabela; i++) {
      Map<String, String> valores = {};
      for (int j = 0; j < variaveis.length; j++) {
        valores[variaveis[j]] = (bin[j] == '0') ? "1" : "0";

        if (array_answer_table[variaveis[j]] == null) {
          array_answer_table[variaveis[j]] = [];
        }
        array_answer_table[variaveis[j]]!.add((bin[j] == '0') ? "V" : "F");
      }
      //Para cada combinação, a função calculate_expression
      // é chamada para calcular o resultado da expressão com base nos valores das variáveis.
      var resposta = calculate_expression(expression, valores);
      //Em seguida, a resposta é dividida em partes usando split('|'),
      // e cada parte é processada para preencher a tabela de respostas array_answer_table.
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

    //Por fim, o resultado é armazenado em temp_array_answer_table e a quantidade de linhas da tabela em temp_qtde_linhas_tabela.

    temp_array_answer_table = array_answer_table;
    temp_qtde_linhas_tabela = qtde_linhas_tabela;
  }

  String addBinary(String a, String b) {//Esta função recebe duas strings binárias a e b e retorna a soma delas como uma string binária.
    //Ela realiza uma soma binária da direita para a esquerda, tratando os casos em que a soma gera um carry (vai um).
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
    //O primeiro loop verifica se há o operador de negação (∼) seguido de um valor booleano (0 ou 1).
    // Se encontrar, substitui o valor booleano negando-o (0 se torna 1, 1 se torna 0).
    while (RegExp(r'∼(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'∼(0|1)'), (match) {
        String? p = match.group(1);
        return (p == '0') ? '1' : '0';
      });
    }
    //O segundo loop verifica se há o operador de conjunção (∧) entre dois valores booleanos (0 ou 1).
    // Se encontrar, aplica a operação de conjunção, retornando 1 se ambos os valores forem 1, caso contrário, retorna 0.
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
    //O sexto loop verifica se há o operador de bicondicional (↔) entre dois valores booleanos (0 ou 1).
    // Se encontrar, aplica a operação de bicondicional, retornando 1 se ambos os valores forem iguais (1 ou 0), caso contrário, retorna 0.
    while (RegExp(r'(0|1)↔(0|1)').hasMatch(exp)) {
      exp = exp.replaceAllMapped(RegExp(r'(0|1)↔(0|1)'), (match) {
        String? p = match.group(1);
        String? q = match.group(2);
        return ((p == '1' && q == '1') || (p == '0' && q == '0')) ? '1' : '0';
      });
    }
    //Os outros operadores (∨ para disjunção, → para implicação e ⊻ para ou-exclusivo) são tratados de maneira
    // semelhante em loops subsequentes, onde a função encontra o operador correspondente e realiza a operação apropriada nos valores booleanos.
    return exp;
  }

  List<String> calculate_expression(String exp, Map<String, dynamic> obj, [String string_result = ""]) {//Essa função recebe uma expressão exp, um objeto obj contendo variáveis e um parâmetro opcional string_result inicializado como uma string vazia.
    int cont = 0;//Ela cria um contador cont
    Map<String, dynamic> exp_dicio = {};//dicionário exp_dicio vazio.
    String result = "(${exp})";//A expressão exp é encapsulada entre parênteses e armazenada em result.
    //Em seguida, entra em um loop que procura por trechos da expressão entre parênteses usando uma expressão regular.
    // A cada iteração, substitui o trecho encontrado por uma chave única [Pcont] no exp_dicio e incrementa o contador cont.
    while (result.contains(RegExp(r"\(([^\(\)]*)\)"))) {
      cont++;
      result = result.replaceAllMapped(RegExp(r"\(([^\(\)]*)\)"), (match) {
        exp_dicio["[P${cont}]"] = {};
        exp_dicio["[P${cont}]"]["exp"] = match.group(1);
        return "[P${cont}]";
      });
    }
    //Depois, entra em um segundo loop que substitui todas as ocorrências das chaves [Pcont]
    // no raw_inner_exp pela expressão correspondente no exp_dicio.
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
      //Então, substitui [Verdadeiro] por "1" e [Falso] por "0" na expressão modificada.
      modified_inner_exp = modified_inner_exp.replaceAll("[Verdadeiro]", "1").replaceAll("[Falso]", "0");
      //Em seguida, substitui todas as variáveis no modified_inner_exp pelos valores correspondentes no objeto obj.
      for (String variable in obj.keys) {
        modified_inner_exp = modified_inner_exp.replaceAll(variable, obj[variable].toString());
      }
      exp_dicio[inner_exp]["value"] = calculate_inner_expression(modified_inner_exp);//Calcula o valor da expressão modificada usando a função calculate_inner_expression.
      //Finalmente, concatena informações sobre a expressão original e seu valor calculado em
      // string_result e retorna uma lista contendo result (a expressão final) e string_result (informações sobre as expressões internas).
      string_result = "${string_result}|${raw_inner_exp}:${exp_dicio[inner_exp]["value"]}";
    }
    return [result, string_result];
  }

  bool isRepeatedVar(String str, List<String> array) {//Esta função verifica se uma string str está contida em uma lista array.
    return array.contains(str);//Retorna true se str estiver na lista e false caso contrário.
  }

  var arrayElement = [];

  tableElements(Map<dynamic, dynamic> obj) {//Esta função recebe um objeto obj.
    var arrayElement = [];//Inicializa uma lista arrayElement vazia.
    if (obj.isNotEmpty) {//Verifica se o objeto não está vazio.
      var keys = obj.keys;
      for (var element in keys) {//Se o objeto não estiver vazio, obtém as chaves do objeto e as adiciona à lista arrayElement.
        arrayElement.add(element);
      }
      this.arrayElement = arrayElement;// Em seguida, atualiza a variável de classe arrayElement com a lista resultante.
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

  void digito(String btnVal) { // Insere o valor digitado na expressão
    setState(() {
      if(calcular) {
        if (btnVal == '∼') {
          if (expression.endsWith('∼')) return; //impede de escrever 2 vezes seguidas o ∼
        } else {
          if (isLogicalOperator(btnVal) &&
              isLogicalOperator(expression.substring(expression.length - 1))) // verificar se oque foi digitado é um operador logico e se oque foi escrito antes é um operador logico
            return;
          if (isLogicalOperator(btnVal) &&
              expression.substring(expression.length - 1) == '') return; // verificar se oque foi digitado é um operador logico e se oque foi escrito antes é igual a esse operador logico
        }
        if ((isVariable(btnVal) ||
            btnVal == '[Verdadeiro]' || // aqui ele verificar se foi apertado o botao de verdadeiro ou falso
            btnVal == '[Falso]') &&
            (isVariable(expression.substring(expression.length - 1)) ||
                RegExp(r'\[(?:Verdadeiro|Falso)\]$').hasMatch(expression))) { // aqui ele verificar se foi ja foi escrito antes verdadeiro ou falso para não se criar um calculo invalido
          return;
        }

        if (btnVal == "(" &&
            isVariable(expression.substring(expression.length - 1))) { //impede de criar uma expressão incorreta "A("
          return;
        }
        if (btnVal == ')' && //aqui verificar quantos parentese de fechamento podem ser colocados
            (expression
                .replaceAll(RegExp(r'[^\(]'), '')
                .length <=
                expression
                    .replaceAll(RegExp(r'[^\)]'), '')
                    .length)) {
          return;
        }
        if (btnVal == ')' && expression.endsWith("(")) { //impede o fechamento do parentese sem nada dentro
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
