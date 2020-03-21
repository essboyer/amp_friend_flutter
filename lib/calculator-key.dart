import 'package:flutter/material.dart';
import 'package:amp_friend_flutter/key-controller.dart';
import 'package:amp_friend_flutter/key-symbol.dart';

abstract class Keys {
  static KeySymbol rms =
      KeySymbol('RMS', keyType: KeyType.FUNCTION, altText: 'P2P');
  static KeySymbol voltage =
      KeySymbol('V', keyType: KeyType.FUNCTION, altText: 'W');

  static KeySymbol clear = KeySymbol('Del', keyType: KeyType.CLEAR);
  static KeySymbol decimal = KeySymbol('.', keyType: KeyType.DECIMAL);

  static KeySymbol zero = KeySymbol('0');

  static KeySymbol one = KeySymbol('1');
  static KeySymbol two = KeySymbol('2');
  static KeySymbol three = KeySymbol('3');

  static KeySymbol four = KeySymbol('4');
  static KeySymbol five = KeySymbol('5');
  static KeySymbol six = KeySymbol('6');

  static KeySymbol seven = KeySymbol('7');
  static KeySymbol eight = KeySymbol('8');
  static KeySymbol nine = KeySymbol('9');
}

class CalculatorKey extends StatefulWidget {
  CalculatorKey({this.symbol});

  final KeySymbol symbol;

  @override
  CalculatorKeyState createState() => CalculatorKeyState();
}

class CalculatorKeyState extends State<CalculatorKey> {
  bool toggled = false;
  bool isLongPressed = false;

  dynamic _fire(CalculatorKeyState key) {
    KeyEvent ke = KeyEvent(widget);
    ke.isLongPressed = isLongPressed;
    KeyController.fire(ke);
  }

  Color get color {
    switch (widget.symbol.keyType) {
      case KeyType.CLEAR:
        return Colors.red;
      case KeyType.FUNCTION:
        if (toggled) {
          return Colors.blue;
        }
        return Colors.green;

      case KeyType.INTEGER:
      default:
        return Color.fromARGB(255, 128, 128, 128);
    }
  }

  String get label {
    return (widget.symbol.keyType == KeyType.FUNCTION && toggled
        ? widget.symbol.altText
        : widget.symbol.value);
  }

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width) / 3;
    TextStyle style =
        Theme.of(context).textTheme.headline4.copyWith(color: Colors.white);

    return Container(
        width: (widget.symbol == Keys.zero) ? (size * 2) : size,
        padding: EdgeInsets.all(20),
        height: size - 10,
        child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: color,
            elevation: 4,
            child: Text(label, style: style),
            onPressed: () {
              if (widget.symbol.keyType == KeyType.CLEAR) {
                isLongPressed = false;
              }

              if (widget.symbol.keyType == KeyType.FUNCTION) {
                setState(() {
                  toggled = !toggled;
                });
              }

              return _fire(this);
            },
            onLongPress: () {
              if (widget.symbol.keyType == KeyType.CLEAR) {
                setState(() {
                  isLongPressed = true;
                });
              }

              return _fire(this);
            }));
  }
}
