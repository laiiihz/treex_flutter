import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';

class SingleBlockWidget extends StatefulWidget {
  SingleBlockWidget({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.color,
    this.callback,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback callback;

  @override
  State<StatefulWidget> createState() => _SingleBlockState();
}

class _SingleBlockState extends State<SingleBlockWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
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
            onTap: widget.callback,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 50,
                  color: Colors.white,
                ),
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        height: 100,
        decoration: BoxDecoration(
          color: provider.nightModeOn ? Color(0xff444444) : widget.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            provider.nightModeOn
                ? BoxShadow(
              blurRadius: 0,
              color: Colors.transparent,
            )
                : BoxShadow(
                    blurRadius: 20,
                    color: widget.color,
                  )
          ],
        ),
      ),
    );
  }
}
