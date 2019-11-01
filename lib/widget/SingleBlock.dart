import 'package:flutter/material.dart';

class SingleBlockWidget extends StatefulWidget {
  SingleBlockWidget({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.color,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;

  @override
  State<StatefulWidget> createState() => _SingleBlockState();
}

class _SingleBlockState extends State<SingleBlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 50,
                ),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
        height: 100,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: widget.color,
            )
          ],
        ),
      ),
    );
  }
}
