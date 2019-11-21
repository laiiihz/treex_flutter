import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';

class MoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MovieState();
}

class _MovieState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('MOVIES'),
            expandedHeight: 200,
            flexibleSpace: Align(
              alignment: Alignment.centerRight.add(Alignment(-0.1, 0)),
              child: Hero(
                tag: 'movies',
                child: Icon(
                  getDisplayIcon('movies'),
                  size: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
