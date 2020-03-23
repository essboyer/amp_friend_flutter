import 'package:flutter/material.dart';
import 'package:amp_friend_flutter/display.dart';
import 'package:amp_friend_flutter/key-controller.dart';
import 'package:amp_friend_flutter/key-pad.dart';
import 'package:amp_friend_flutter/processor.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  void initState() {
    KeyController.listen((event) {
      Processor.process(event);
      Processor.calculate();
    });
    Processor.refresh();
    super.initState();
  }

  @override
  void dispose() {
    KeyController.dispose();
    Processor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(196, 32, 64, 96),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[Display(), KeyPad()]),
    );
  }
}
