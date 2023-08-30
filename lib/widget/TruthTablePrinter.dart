import 'package:flutter/material.dart';

class TruthTable extends StatelessWidget {
  final List<String> items;
  final int itemsPerRow;

  TruthTable({
    Key? key,
    required this.items,
    required this.itemsPerRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(width: 1),
        ),
        children: [
          for (int i = 0; i < items.length; i += itemsPerRow)
            buildRow(items.sublist(i, i + itemsPerRow > items.length
                ? items.length
                : i + itemsPerRow)),
        ],
      ),
    );
  }

  TableRow buildRow(List<String> cells) => TableRow(
    children: cells.map((cell) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(cell,style: const TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
          ),),
        ),
      );
    }).toList(),
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'A', 'V', 'V', 'F', 'F', 'B', 'V', 'F', 'V', 'F'
    ];

    int itemsPerRow = 5; // Defina o número de itens por linha

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tabela de Itens'),
        ),
        body: Center(
          child: Column(
            children: [
              TruthTable(
                items: items,
                itemsPerRow: itemsPerRow,
              ),
              SizedBox(height: 20),
              Text(items.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
