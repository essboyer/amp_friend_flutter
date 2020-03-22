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
        .headline6
        .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

    List<Widget> children = [];

    _resultsModel.results.forEach((key, value) {
      children.add(Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(key.toString() + " \u03A9",
              style: resultStyle1, textAlign: TextAlign.right),
          Text(value.toStringAsFixed(2), style: resultStyle2, textAlign: TextAlign.right)
        ],
      ));
    });

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: children);
  }
}

class Display extends StatefulWidget {
  Display({Key key, this.height}) : super(key: key);

  final double height;

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  //String get _output => widget.resultsModel.display;

  double get _margin => (widget.height / 10);

  final LinearGradient _gradient =
      const LinearGradient(colors: [Colors.black26, Colors.black45]);

  @override
  Widget build(BuildContext context) {
    final ResultsModel _resultsModel = Provider.of<ResultsModel>(context);
    Processor.resultsModel = _resultsModel;

    TextStyle inputStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Colors.white, fontWeight: FontWeight.w400);

    return Container(
        //padding: EdgeInsets.only(top: _margin, bottom: _margin),
        //constraints: BoxConstraints.expand(height: height),
        child: Container(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
            //constraints: BoxConstraints.expand(height: height - (_margin)),
            decoration: BoxDecoration(gradient: _gradient),
            child: Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Text(_resultsModel.display,
                    style: inputStyle, textAlign: TextAlign.right)
              ]),
              ResultsBuilder()
            ])));
  }
}
