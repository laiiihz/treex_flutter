import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class MusicHelperPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MusicHelperState();
}

class _MusicHelperState extends State<MusicHelperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 80,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                  Hero(
                    tag: 'music_face',
                    child: CircleAvatar(
                      child: Text(
                        'F',
                        style: TextStyle(fontSize: 100),
                      ),
                      minRadius: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onRefresh: () async {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
