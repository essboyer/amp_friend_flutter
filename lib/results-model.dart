import 'package:flutter/cupertino.dart';

class ResultsModel extends ChangeNotifier {
  String _display = "0";
  Map<int, double> _results = {};
  bool _isRMS = true;
  bool _isVoltage = true;

  String get display => _display;
  Map<int, double> get results => _results;
  bool get isRMS => _isRMS;
  bool get isVoltage => _isVoltage;

  set display(String value) {
    _display = value;
	print("I got called!");
    notifyListeners();
  }

  set results(Map<int, double> value) {
    _results = value;
    notifyListeners();
  }

  set isRMS(bool value) {
	  _isRMS = value;
	  notifyListeners();
  }

  set isVoltage(bool value) {
	  _isVoltage = value;
	  notifyListeners();
  }

}
