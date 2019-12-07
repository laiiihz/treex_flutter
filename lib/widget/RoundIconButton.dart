import 'package:flutter/material.dart';

class RoundIconButtonWidget extends StatelessWidget {
  RoundIconButtonWidget({Key key, @required this.onPress, @required this.icon})
      : super(key: key);
  final VoidCallback onPress;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: this.onPress,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: this.icon,
        ),
      ),
    );
    ;
  }
}
