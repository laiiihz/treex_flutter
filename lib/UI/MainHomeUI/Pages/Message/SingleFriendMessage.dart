import 'package:flutter/material.dart';
import 'package:treex_flutter/ColorSchemes.dart';

class SingleFriendMessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleFriendMessageState();
}

class _SingleFriendMessageState extends State<SingleFriendMessagePage> {
  ScrollController _scrollController = ScrollController();
  bool _showTextField = true;
  bool _delayShowTextField = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          milliseconds: 500,
        ), () {
      _scrollController.animateTo(
        -100,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
    int scrollLock = 0;
    _scrollController.addListener(() {
      if (_scrollController.offset < 200) {
        scrollLock += 1;
        if (scrollLock == 1) {
          setState(() {
            _showTextField = true;
            _delayShowTextField = true;
          });
          Future.delayed(
              Duration(
                milliseconds: 500,
              ), () {
            scrollLock = 0;
          });
        }
      } else {
        scrollLock += 1;
        if (scrollLock == 1) {
          setState(() {
            _showTextField = false;
          });

          Future.delayed(
              Duration(
                milliseconds: 500,
              ), () {
            scrollLock = 0;
            _delayShowTextField = false;
            FocusScope.of(context).requestFocus(FocusNode());
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              blurRadius: 20,
              color: tealBackgroundDark,
            )],
          ),
          child: AppBar(
            title: Text('NAME'),
            centerTitle: true,
          ),
        ),
        preferredSize: Size.fromHeight(60),
      ),
      floatingActionButton: _showTextField
          ? null
          : FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.easeInExpo,
                );
              },
              heroTag: 'add_menu',
              child: Icon(Icons.sms),
            ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return Text('message');
              },
            ),
          ),
          Offstage(
            offstage: !_delayShowTextField,
            child: AnimatedContainer(
              height: _showTextField ? 80 : 0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: TextField(),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 20,
                  ),
                ],
              ),
              duration: Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }
}
