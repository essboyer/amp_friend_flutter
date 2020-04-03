import 'package:flutter/widgets.dart';
import 'package:amp_friend_flutter/calculator-key.dart';

class KeyPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Expanded(
		flex: 4,
        child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
          CalculatorKey(symbol: Keys.clear),
          CalculatorKey(symbol: Keys.rms),
          CalculatorKey(symbol: Keys.voltage),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
          CalculatorKey(symbol: Keys.seven),
          CalculatorKey(symbol: Keys.eight),
          CalculatorKey(symbol: Keys.nine),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
          CalculatorKey(symbol: Keys.four),
          CalculatorKey(symbol: Keys.five),
          CalculatorKey(symbol: Keys.six),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
          CalculatorKey(symbol: Keys.one),
          CalculatorKey(symbol: Keys.two),
          CalculatorKey(symbol: Keys.three),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
          CalculatorKey(symbol: Keys.zero),
          CalculatorKey(symbol: Keys.decimal),
        ]),
      ],
    ));
  }
}
