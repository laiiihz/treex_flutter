import 'package:flutter/material.dart';


class FadeWidget extends StatefulWidget {
  FadeWidget({Key key, @required this.child, @required this.hash, this.test})
      : super(key: key);
  final Widget child;
  final int hash;
  final int test;
  @override
  State<StatefulWidget> createState() => _FadeState();
}

class _FadeState extends State<FadeWidget> {
  final ValueNotifier<int> _changedValue = ValueNotifier<int>(0);
  @override
  void initState() {
    super.initState();
    print(widget.test);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(
        milliseconds: 500,
      ),
      child: ValueListenableBuilder(
        valueListenable: _changedValue,
        builder: (context, value, child) {
          print(value);
          return child;
        },
      ),
    );
  }
}
