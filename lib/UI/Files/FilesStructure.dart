import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';

class FilesStructurePage extends StatefulWidget {
  FilesStructurePage({
    Key key,
    this.isCloud = false,
    @required this.prefix,
    @required this.pathList,
    @required this.suffix,
    @required this.child,
  }) : super(key: key);
  final bool isCloud;
  final Widget prefix;
  final Widget pathList;
  final Widget suffix;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _FilesStructureState();
}

class _FilesStructureState extends State<FilesStructurePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Color(0xff333333)
                : yellowBackgroundDark,
            boxShadow: [
              BoxShadow(
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.white30
                        : Colors.black38,
                offset: Offset(0, 5),
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              widget.prefix,
              Expanded(child: widget.pathList),
              widget.suffix,
            ],
          ),
        ),
      ],
    );
  }
}
