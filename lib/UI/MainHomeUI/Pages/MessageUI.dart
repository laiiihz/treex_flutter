import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/Message/Friends.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/Message/SingleFriendMessage.dart';

class MessageUIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageUIState();
}

class _MessageUIState extends State<MessageUIPage> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          color: Colors.black38,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  width: 50,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(5),
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTapUp: (detail) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 600),
                            pageBuilder: (context, animation, animationSub) {
                              return ScaleTransition(
                                scale: animation,
                                alignment: FractionalOffset(
                                  detail.globalPosition.dx /
                                      MediaQuery.of(context).size.width,
                                  detail.globalPosition.dy /
                                      MediaQuery.of(context).size.height,
                                ),
                                child: FriendsPage(),
                              );
                            }),
                      );
                    },
                    child: Icon(Icons.more_horiz),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                onDismissed: (direction) {},
                background: Container(
                  color: Colors.red,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete),
                      Spacer(),
                      Icon(Icons.delete),
                    ],
                  ),
                ),
                key: Key('#list_key$index'),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: GestureDetector(
                        onTapUp: (detail) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, animationSub) {
                                return ScaleTransition(
                                  scale: animation,
                                  alignment: FractionalOffset(
                                      0.0,
                                      detail.globalPosition.dy /
                                          MediaQuery.of(context).size.height),
                                  child: SingleFriendMessagePage(),
                                );
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Badge(
                            badgeContent: Text(
                              '5',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: CircleAvatar(),
                            animationType: BadgeAnimationType.slide,
                          ),
                          title: Text('name'),
                          subtitle: Text('message'),
                          trailing: Text('12:30'),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      height: 0,
                      indent: 70,
                    ),
                  ],
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
