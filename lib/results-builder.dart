import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'results-model.dart';

class ResultsBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultsModel _resultsModel = Provider.of<ResultsModel>(context);

    TextStyle resultStyle1 = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(color: Colors.white, fontWeight: FontWeight.w800);

    TextStyle resultStyle2 = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

    List<Widget> children = [];

    _resultsModel.results.forEach((key, value) {
      children.add(Column(
        children: <Widget>[
          Text(key.toString() + " \u03A9",
              style: resultStyle1, textAlign: TextAlign.start),
          Text(value.toStringAsFixed(1) + (_resultsModel.isVoltage ? "V" : "W"),
              style: resultStyle2, textAlign: TextAlign.start)
        ],
      ));
    });

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children);
  }
}