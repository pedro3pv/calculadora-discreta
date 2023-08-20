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
  String expression = "";

  bool is_variable(String btnVal) {
    if (btnVal.codeUnitAt(0) > 64 && btnVal.codeUnitAt(0) < 91) {
      return true;
    }
    return false;
  }

  bool is_logical_operator(String btnVal) {
    for (String element in OPERATORS) {
      if (btnVal == element) return true;
    }
    return false;
  }

  void digito(String btnVal){
    setState(() {

      print(btnVal);
      if (btnVal == '∼') {
        if (expression.substring(expression.length - 1) == '∼') return;
      } else {
        if (is_logical_operator(btnVal) && is_logical_operator(expression.substring(expression.length - 1))) return;
        if (is_logical_operator(btnVal) && expression.substring(expression.length - 1) == '') return;
      }
      if ((is_variable(btnVal) || btnVal == '[Verdadeiro]' || btnVal == '[Falso]') && (is_variable(expression.substring(expression.length - 1)) || expression.contains(RegExp(r"\[(?:Verdadeiro|Falso)\]$")))) return;
      if (btnVal == '(' && is_variable(expression.substring(expression.length - 1))) return;
      if (btnVal == ')' && (expression.replaceAll(RegExp(r"[^\(]"), '').length <= expression.replaceAll(RegExp(r"[^\)]"), '').length)) return;
      if (btnVal == ')' && expression.substring(expression.length - 1) == "(") return;
      expression = expression + btnVal;
    });
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
                        button_specialy(text: 'C',),
                        button_specialy2(),
                        button_calculator(text: 'E',callback: digito,),
                        button_calculator(text: 'F',callback: digito,),
                        button_calculator(text: 'G',callback: digito,),
                        button_calculator(text: 'H',callback: digito,),
                        button_specialy3(text: "("),
                        button_specialy3(text: ")"),
                        button_calculator(text: 'I',callback: digito,),
                        button_calculator(text: 'J',callback: digito,),
                        button_calculator(text: 'K',callback: digito,),
                        button_calculator(text: 'L',callback: digito,),
                        button_specialy4(),
                        button_specialy5(),
                        button_calculator(text: 'M',callback: digito,),
                        button_calculator(text: 'N',callback: digito,),
                        button_calculator(text: 'O',callback: digito,),
                        button_calculator(text: 'P',callback: digito,),
                        button_specialy6(),
                        button_specialy7(),
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
                              button_specialy8(text: '~',),
                              button_calculator(text: 'U',callback: digito,),
                              button_calculator(text: 'V',callback: digito,),
                              button_calculator(text: 'W',callback: digito,),
                              button_calculator(text: 'X',callback: digito,),
                              button_specialy10(text: 'V',),
                              button_invisible(),
                              button_calculator(text: 'Y',callback: digito,),
                              button_calculator(text: 'Z',callback: digito,),
                              button_invisible(),
                              button_specialy11(text: 'F',),
                            ],
                          ),
                        ),
                    Container(
                      width: 76,
                      height: 216,
                      child: const Wrap(
                        children: [
                          button_specialy9(text: '=',),
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