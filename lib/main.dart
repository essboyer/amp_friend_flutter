import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:amp_friend_flutter/calculator.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Calculator(),
    );
  }
}
