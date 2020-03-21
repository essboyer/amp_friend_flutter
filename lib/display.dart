import 'package:flutter/material.dart';

class ResultsBuilder extends StatelessWidget {
	ResultsBuilder(this.results);
	final Map<int, double> results;

  @override
  Widget build(BuildContext context) {
	  TextStyle resultStyle = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(color: Colors.white, fontWeight: FontWeight.w200);

		List<Widget> children = [];

		results.forEach((key, value) {
			children.add(Text(key.toString() + " \u03A9", style: resultStyle, textAlign: TextAlign.right));
			children.add(Text(value.toString(), style: resultStyle, textAlign: TextAlign.right));
		});

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: children);
  }
	
}

class Display extends StatefulWidget {
  Display({Key key, this.value, this.results, this.height}) : super(key: key);

  final String value;
  final double height;
  final Map<int, double> results;

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String get _output => widget.value.toString();

  double get _margin => (widget.height / 10);

  final LinearGradient _gradient =
      const LinearGradient(colors: [Colors.black26, Colors.black45]);

  @override
  Widget build(BuildContext context) {
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
					Row(mainAxisAlignment: MainAxisAlignment.end,
						children: <Widget>[
						Text(_output, style: inputStyle, textAlign: TextAlign.right)
					]),
					ResultsBuilder(widget.results)
				])
			)
		);
	}
}
