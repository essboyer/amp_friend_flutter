import 'package:flutter/cupertino.dart';

class ResultsModel extends ChangeNotifier {
  String _display = "0";
  Map<int, double> _results = {};

  String get display => _display;
  Map<int, double> get results => _results;
  set display(String value) {
    _display = value;
	print("I got called!");
    notifyListeners();
  }

  set results(Map<int, double> value) {
    _results = value;
    notifyListeners();
  }
}
