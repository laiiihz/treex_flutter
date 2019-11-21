import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/helpers/MusicHelper.dart';

class MusicListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MusicListState();
}

class _MusicListState extends State<MusicListPage> {
  bool _openMusicface = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                title: Text('MUSIC'),
                expandedHeight: 200,
                flexibleSpace: Align(
                  alignment: Alignment.centerRight.add(Alignment(-0.2, 0)),
                  child: Hero(
                      tag: 'music',
                      child: Icon(
                        getDisplayIcon('music'),
                        color: Colors.white,
                        size: 80,
                      )),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ListTile(
                    title: Text(index.toString()),
                  );
                }),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              height: _openMusicface ? MediaQuery.of(context).size.height : 80,
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  LinearProgressIndicator(),
                  Expanded(
                    child: Material(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: InkWell(
                              child: Hero(
                                tag: 'music_face',
                                child: CircleAvatar(child: Text('F')),
                              ),
                              onTap: () {
                                setState(() {
                                  _openMusicface = true;
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MusicHelperPage(),
                                  ),
                                );
                                Future.delayed(Duration(milliseconds: 500), () {
                                  setState(() {
                                    _openMusicface = false;
                                  });
                                });
                              },
                            ),
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.pause), onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.skip_next), onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
