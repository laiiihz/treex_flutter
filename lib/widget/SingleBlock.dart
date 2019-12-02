import 'package:badges/badges.dart';
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
    this.smallText = false,
    this.showBadge = false,
    this.badgeChild,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback callback;
  final bool smallText;
  final bool showBadge;
  final Widget badgeChild;

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
                Badge(
                  child: Icon(
                    widget.icon,
                    size: 50,
                    color: Colors.white,
                  ),
                  badgeColor: Colors.white54,
                  elevation: 0,
                  badgeContent: widget.badgeChild,
                  showBadge: widget.showBadge,
                  borderRadius: 5,
                  shape: BadgeShape.square,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: widget.smallText ? 15 : 30,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        height: 100,
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Color(0xff444444)
              : widget.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            MediaQuery.of(context).platformBrightness == Brightness.dark
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
