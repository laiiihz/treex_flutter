import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';

class DocumentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DocumentState();
}

class _DocumentState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Document'),
            expandedHeight: 200,
            flexibleSpace: Align(
              alignment: Alignment.centerRight.add(Alignment(-0.2, 0)),
              child: Hero(
                  tag: 'docs',
                  child: Icon(
                    getDisplayIcon('docs'),
                    color: Colors.white,
                    size: 80,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
