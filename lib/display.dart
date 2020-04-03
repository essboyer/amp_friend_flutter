import 'package:flutter/material.dart';
import 'package:amp_friend_flutter/results-model.dart';
import 'package:provider/provider.dart';

import 'processor.dart';

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

class Display extends StatefulWidget {
  Display({Key key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  final LinearGradient _gradient =
      const LinearGradient(colors: [Colors.black26, Colors.black45]);

  @override
  Widget build(BuildContext context) {
    final ResultsModel _resultsModel = Provider.of<ResultsModel>(context);
    final String inputText =
        (_resultsModel.isVoltage ? (_resultsModel.isRMS ? "Vrms" : "V") : "W");
    Processor.resultsModel = _resultsModel;

    TextStyle inputStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Colors.white, fontWeight: FontWeight.w400);

    return Expanded(
      flex: 4,
      child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 52, 10, 2),
              decoration: BoxDecoration(gradient: _gradient),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(_resultsModel.display,
                          style: inputStyle, textAlign: TextAlign.right),
                      Text(
                        " " + inputText,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
					SizedBox( height: 20),
                ResultsBuilder()
              ]))),
    );
  }
}
