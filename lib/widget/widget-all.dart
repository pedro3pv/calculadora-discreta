import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math' as math;

class screen extends StatelessWidget {
  final String calculo;

  const screen({
    super.key,
    required this.calculo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 402,
          height: 93,
          padding: const EdgeInsets.only(left: 18, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 93,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '=',
                          style: TextStyle(
                            color: Color(0xFF6B6B6B),
                            decoration: TextDecoration.none,
                            fontSize: 32,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.48,
                          ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          calculo,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFFEAEAEA),
                            decoration: TextDecoration.none,
                            fontSize: 36,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.72,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_calculator extends StatelessWidget {
  final String text;
  final Function callback;

  const button_calculator({
    super.key,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
        onTap: () => callback(text),
        child: Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [Colors.black.withOpacity(0.05000000074505806), Colors.white.withOpacity(0.05000000074505806)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFEAEAEA),
                      decoration: TextDecoration.none,
                      fontSize: 24,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.48,
                    ),
                  ),
              ),
            ],
          ),
        ),
        ),
      ],
    );
  }
}

class button_specialy extends StatelessWidget {
  final String text;

  const button_specialy({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF6D61A9),Color(0xFF6D61A9)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy2 extends StatelessWidget {

  const button_specialy2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFFDEB189),Color(0xFFDEB189)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.backspace,
                  color: Colors.white,
                  size: 32,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy3 extends StatelessWidget {
  final String text;

  const button_specialy3({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF462878),Color(0xFF462878)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy4 extends StatelessWidget {

  const button_specialy4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF462878),Color(0xFF462878)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.east,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy5 extends StatelessWidget {

  const button_specialy5({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF462878),Color(0xFF462878)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.expand_less,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy6 extends StatelessWidget {

  const button_specialy6({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF462878),Color(0xFF462878)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Transform.rotate(
            angle: 45 * math.pi / 180,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.open_in_full,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          )
        ),
      ],
    );
  }
}

class button_specialy7 extends StatelessWidget {

  const button_specialy7({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF462878),Color(0xFF462878)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.expand_more,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class button_specialy8 extends StatelessWidget {
  final String text;

  const button_specialy8({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF7F45E2),Color(0xFF7F45E2)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy9 extends StatelessWidget {
  final String text;

  const button_specialy9({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 216,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF7F45E2),Color(0xFF7F45E2)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 62,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy10 extends StatelessWidget {
  final String text;

  const button_specialy10({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF86A154),Color(0xFF86A154)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_specialy11 extends StatelessWidget {
  final String text;

  const button_specialy11({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFFB6131D),Color(0xFFB6131D)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 32,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class button_invisible extends StatelessWidget {

  const button_invisible({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
      ],
    );
  }
}

class button_calculator2 extends StatelessWidget {
  final String text;
  final double direita;
  final double esquerda;
  final double topo;
  final double baixo;

  const button_calculator2({
    super.key,
    required this.text,
    required this.direita,
    required this.esquerda,
    required this.topo,
    required this.baixo
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          margin: EdgeInsets.only(
            top: topo,
            bottom: baixo,
            right: direita,
            left: esquerda,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [Colors.black.withOpacity(0.05000000074505806), Colors.white.withOpacity(0.05000000074505806)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x49000000),
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x42000000),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x19000000),
                blurRadius: 6,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 7,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),BoxShadow(
                color: Color(0x02000000),
                blurRadius: 7,
                offset: Offset(0, 11),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFEAEAEA),
                    decoration: TextDecoration.none,
                    fontSize: 24,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}