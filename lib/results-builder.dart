import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'results-model.dart';

class ResultsBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultsModel _resultsModel = Provider.of<ResultsModel>(context);

    final TextStyle resultStyle1 = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Colors.white, fontWeight: FontWeight.w800);

    final TextStyle resultStyle2 = Theme.of(context)
        .textTheme
        .headline5
        .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

	final f = new NumberFormat("###,###.#");

    final List<Widget> children = [];
	final Row row1 = new Row(children: [], mainAxisAlignment: MainAxisAlignment.spaceBetween);
	final Row row2 = new Row(children: [], mainAxisAlignment: MainAxisAlignment.spaceBetween);

    _resultsModel.results.forEach((key, value) {
		final Column col = Column(
        children: <Widget>[
          Text(key.toString() + " \u03A9",
              style: resultStyle1, textAlign: TextAlign.start),
          Text(f.format(value) + (_resultsModel.isVoltage ? "W" : "V"),
              style: resultStyle2, textAlign: TextAlign.start)
        ],
      );

	  if (key == 2 || key == 4) {
		  row1.children.add(col);
	  } else {
		  row2.children.add(col);
	  }
    });

	final Column bigCol = Column(children: [], crossAxisAlignment: CrossAxisAlignment.center,);
	bigCol.children.add(row1);
	bigCol.children.add(SizedBox(height: 20));
	bigCol.children.add(row2);
	children.add(bigCol);


    return bigCol;
  }
}