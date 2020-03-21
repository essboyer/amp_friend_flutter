import 'package:flutter/material.dart';
import 'package:flutter_calculator_demo/display.dart';
import 'package:flutter_calculator_demo/key-controller.dart';
import 'package:flutter_calculator_demo/key-pad.dart';
import 'package:flutter_calculator_demo/processor.dart';

class Calculator extends StatefulWidget {

	Calculator({ Key key }) : super(key: key);

	@override
	_CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

	String _output;
	Map<int, double> _results = {};

	@override
	void initState() {
		KeyController.listen((event) => Processor.process(event));
		Processor.listen((data) => setState(() { _output = data; }));
		Processor.refresh();
		super.initState();
	}

	@override
	void dispose() {
		KeyController.dispose();
		Processor.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {

		Size screen = MediaQuery.of(context).size;

		double buttonSize = screen.width / 6;
		double displayHeight = buttonSize * 1.6;//screen.height - (buttonSize * 6);
	
		return Scaffold(
			backgroundColor: Color.fromARGB(196, 32, 64, 96),
			body: Column(mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Display(value: _output, height: displayHeight, results: _results),
					KeyPad()
				]
			),
		);
	}
}