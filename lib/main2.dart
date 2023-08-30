import 'package:flutter/material.dart';
import 'package:test2/widget/TruthTablePrinter.dart';

class table extends StatelessWidget {
  final List<String> arrayElement;
  final int tamanhoTabela;

  const table({super.key, required this.arrayElement, required this.tamanhoTabela});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ButtonBar(
          alignment: MainAxisAlignment.center,
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
              TruthTable(items: arrayElement, itemsPerRow: tamanhoTabela,)
            ],
          ),
        ),
      ),
    );
  }
}
