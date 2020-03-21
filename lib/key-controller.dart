import 'dart:async';
import 'package:amp_friend_flutter/calculator-key.dart';

class KeyEvent {

	KeyEvent(this.key);
	final CalculatorKey key;
	bool _isLongPressed = false;

	set isLongPressed(bool ilp) {
		_isLongPressed = ilp;
	}
	get isLongPressed => _isLongPressed;

}

abstract class KeyController {

	static StreamController _controller = StreamController();
	static Stream get _stream => _controller.stream;

	static StreamSubscription listen(Function handler) => _stream.listen(handler as dynamic);
	static void fire(KeyEvent event) => _controller.add(event);

	static dispose() => _controller.close();
}