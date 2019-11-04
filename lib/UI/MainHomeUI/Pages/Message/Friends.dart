import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/Message/SingleFriendMessage.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendsState();
}

class _FriendsState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        heroTag: 'add_menu',
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SingleFriendMessagePage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Text('test'),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                indent: 70,
              ),
            ],
          );
        },
      ),
    );
  }
}
