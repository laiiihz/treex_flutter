import 'package:flutter/material.dart';

class MessageContentWidget extends StatefulWidget {
  MessageContentWidget({
    Key key,
    this.isRight = false,
    @required this.child,
    this.color = Colors.teal,
  }) : super(key: key);
  final bool isRight;
  final Widget child;
  final Color color;
  @override
  State<StatefulWidget> createState() => _MessageContentState();
}

class _MessageContentState extends State<MessageContentWidget> {
  BorderRadiusGeometry _borderRounded;
  RelativeRect _rect = RelativeRect.fromLTRB(0, 0, 0, 0);
  @override
  void initState() {
    super.initState();
    _borderRounded = BorderRadius.only(
      topLeft: widget.isRight ? Radius.circular(20) : Radius.circular(0),
      topRight: !widget.isRight ? Radius.circular(20) : Radius.circular(0),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.isRight ? Spacer() : SizedBox(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: !widget.isRight ? Colors.black12 : widget.color,
              borderRadius: _borderRounded,
            ),
            child: InkWell(
              borderRadius: _borderRounded,
              onTap: () {},
              onTapDown: (detail) {
                setState(() {
                  _rect = RelativeRect.fromLTRB(
                    detail.globalPosition.dx,
                    detail.globalPosition.dy,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  );
                });
              },
              onLongPress: () {
                showMenu(
                  items: <PopupMenuEntry>[
                    PopupMenuItem(child: Text('test')),
                  ],
                  position: _rect,
                  context: context,
                );
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: widget.child,
              ),
            ),
          ),
        ),
        !widget.isRight ? Spacer() : SizedBox(),
      ],
    );
  }
}
