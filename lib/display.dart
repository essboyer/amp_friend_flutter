import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'results-builder.dart';
import 'results-model.dart';
import 'processor.dart';

class Display extends StatelessWidget {

  final LinearGradient _gradient =
      const LinearGradient(colors: [Colors.black26, Colors.black45]);

  @override
  Widget build(BuildContext context) {
    final ResultsModel _resultsModel = Provider.of<ResultsModel>(context);
    final String inputText =
        (_resultsModel.isVoltage ? (_resultsModel.isRMS ? "Vrms" : "V") : "W");
    Processor.resultsModel = _resultsModel;

    final TextStyle inputStyle = Theme.of(context)
        .textTheme
        .headline2
        .copyWith(color: Colors.white, fontWeight: FontWeight.w400);

    return Expanded(
      flex: 2,
      child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 50, 10, 2),
              decoration: BoxDecoration(gradient: _gradient),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      AutoSizeText(_resultsModel.display,
                          style: inputStyle, textAlign: TextAlign.right),
                      AutoSizeText(
                        " " + inputText,
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                SizedBox(height: 30),
                ResultsBuilder()
              ]))),
    );
  }
}
