import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CloudGridTileWidget extends StatefulWidget {
  CloudGridTileWidget({
    Key key,
    @required this.index,
    @required this.cloudFile,
    @required this.delete,
    @required this.onPressed,
  }) : super(key: key);
  final dynamic cloudFile;
  final int index;
  final VoidCallback delete;
  final VoidCallback onPressed;

  @override
  State<StatefulWidget> createState() => _CloudGridTileState();
}

class _CloudGridTileState extends State<CloudGridTileWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: widget.index,
      columnCount: 3,
      duration: Duration(milliseconds: 400),
      child: SlideAnimation(
        duration: Duration(milliseconds: 400),
        verticalOffset: 50,
        horizontalOffset: 50,
        child: FadeInAnimation(
          child: Card(
            child: InkWell(
              onTap: widget.onPressed,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.cloudFile['isDir']
                        ? Icon(
                            Icons.folder,
                            size: 40,
                            color: Colors.grey,
                          )
                        : Icon(
                            Icons.note,
                            size: 40,
                            color: Colors.grey,
                          ),
                    SizedBox(height: 10),
                    Text(
                      widget.cloudFile['name'],
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
