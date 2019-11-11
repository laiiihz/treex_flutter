import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/Message/SingleFriendMessage.dart';

class FriendDetailPage extends StatefulWidget {
  FriendDetailPage({Key key, @required this.canMessage}) : super(key: key);
  final bool canMessage;
  @override
  State<StatefulWidget> createState() {
    return _FriendDetailsState();
  }
}

class _FriendDetailsState extends State<FriendDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.canMessage
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SingleFriendMessagePage(),
                  ),
                );
              },
              heroTag: 'add_menu',
              child: Icon(Icons.message),
            )
          : null,
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Hero(
                tag: 'friend_hero',
                child: CircleAvatar(),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('NAME'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
