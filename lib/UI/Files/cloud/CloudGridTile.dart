import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CloudGridTileWidget extends StatefulWidget {
  CloudGridTileWidget({Key key, @required this.index}) : super(key: key);
  final int index;
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
        verticalOffset: 50,
        horizontalOffset: 50,
        child: FadeInAnimation(
          child: Card(
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
