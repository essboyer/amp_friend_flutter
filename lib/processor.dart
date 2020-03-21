import 'dart:async';
import 'dart:math';
import 'package:flutter_calculator_demo/calculator-key.dart';
import 'package:flutter_calculator_demo/key-controller.dart';
import 'package:flutter_calculator_demo/key-symbol.dart';

class Processor extends ChangeNotifier {
  static KeySymbol _operator;
  static String _valA = '0';
  static String _valB = '0';
  static String _result;
  static bool _isRMS = true;
  static bool _isVoltage = true;
  static List<int> impedances = [2, 4, 8, 16];
  static Map<int, double> _results;

  static StreamController _controller = StreamController();
  static Stream get _stream => _controller.stream;

  static StreamSubscription listen(Function handler) => _stream.listen(handler);
  static void refresh() {
	  _calculate();
	  _fire(_output);
  }

  static void _fire(String data) {
    _controller.add(_output);
    _controller.add(_results);
  }

  static String get _output => _result == null ? _equation : _result;
  //static Map<int, double> get _results => _results;

  static String get _equation =>
      _valA +
      (_operator != null ? ' ' + _operator.value : '') +
      (_valB != '0' ? ' ' + _valB : '');

  static dispose() => _controller.close();

  static process(dynamic event) {
    CalculatorKey key = (event as KeyEvent).key;
    switch (key.symbol.keyType) {
      case KeyType.DECIMAL:
      case KeyType.FUNCTION:
      case KeyType.CLEAR:
        return handleFunction(key);

      case KeyType.OPERATOR:
        return handleOperator(key);

      case KeyType.INTEGER:
        return handleInteger(key);
        break;
    }
  }

  static void handleFunction(CalculatorKey key) {
    if (_valA == '0') {
      return;
    }
    if (_result != null) {
      _condense();
    }

    Map<KeySymbol, dynamic> table = {
      Keys.clear: () => _clear(),
      Keys.decimal: () => _decimal(),
      Keys.rms: () => _rms(),
      Keys.voltage: () => _voltage()
    };

    table[key.symbol]();
    refresh();
  }

  static void handleOperator(CalculatorKey key) {
    if (_valA == '0') {
      return;
    }
    if (_result != null) {
      _condense();
    }

    _operator = key.symbol;
    refresh();
  }

  static void handleInteger(CalculatorKey key) {
    String val = key.symbol.value;
    if (_operator == null) {
      _valA = (_valA == '0') ? val : _valA + val;
    } else {
      _valB = (_valB == '0') ? val : _valB + val;
    }
    refresh();
  }

  static void _clear() {
    _valA = _valB = '0';
    _operator = _result = null;
  }

  static void _rms() {
    _isRMS = !_isRMS;
  }

  static void _voltage() {
    _isVoltage = !_isVoltage;
  }

  static void _decimal() {
    if (_valB != '0' && !_valB.contains('.')) {
      _valB = _valB + '.';
    } else if (_valA != '0' && !_valA.contains('.')) {
      _valA = _valA + '.';
    }
  }

  static void _calculate() {
    if (_operator == null || _valB == '0') {
      return;
    }

    // If calculating from RMS voltages...
    if (_isRMS) {
      if (_isVoltage) {
        impedances.forEach((e) {
          _results.putIfAbsent(e, () => _findPFromRMS(double.parse(_valA), e));
        });
      } else {
        impedances.forEach((e) {
          _results.putIfAbsent(e, () => -_findRMSFromP(double.parse(_valA), e));
        });
      }
    } else {
      if (_isVoltage) {
        impedances.forEach((e) {
          _results.putIfAbsent(e, () => _findPFromPeak(double.parse(_valA), e));
        });
      } else {
        impedances.forEach((e) {
          _results.putIfAbsent(
              e, () => -_findPeakFromP(double.parse(_valA), e));
        });
      }
    }

/*     double result = 0.0; //TODO Result goes here
    String str = result.toString();

    while ((str.contains('.') && str.endsWith('0')) || str.endsWith('.')) {
      str = str.substring(0, str.length - 1);
    }

    _result = str; */
    refresh();
  }

  static void _condense() {
    _valA = _result;
    _valB = '0';
    _result = _operator = null;
  }

  static double _findPFromRMS(double rmsVolts, int load) {
    return round((((rmsVolts * rmsVolts) / load) * 100)) / 100;
  }

  static double _findPFromPeak(double peakVolts, int load) {
    double rmsVolts = _peak2RMS(peakVolts);
    return _findPFromRMS(rmsVolts, load);
  }

  static double _findRMSFromP(double p, int load) {
    return round(sqrt(p * load) * 100) / 100;
  }

  static double _findPeakFromP(double p, int load) {
    return _rms2Peak(_findRMSFromP(p, load));
  }

  static double _peak2RMS(double peakVolts) {
    return round(0.3535 * peakVolts);
  }

  static double _rms2Peak(double rmsVolts) {
    return round(rmsVolts * (1.414 * 2));
  }

  static double round(double val, {int places = 2}) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
