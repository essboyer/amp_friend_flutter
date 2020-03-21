import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:amp_friend_flutter/calculator.dart';
import 'package:amp_friend_flutter/results-model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ResultsModel(),
    child: CalculatorApp(),
  ));
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider<ResultsModel>.value(
        value: ResultsModel(),
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.teal),
          home: Calculator(),
        ));
  }
}
