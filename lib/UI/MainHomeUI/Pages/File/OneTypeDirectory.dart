import 'package:flutter/material.dart';
import 'package:treex_flutter/widget/FadeWidget.dart';

class OneTypeDirectoryPage extends StatefulWidget {
  OneTypeDirectoryPage({Key key, @required this.color, @required this.title})
      : super(key: key);
  final Color color;
  final String title;
  @override
  State<StatefulWidget> createState() => _OneTypeDirectoryState();
}

class _OneTypeDirectoryState extends State<OneTypeDirectoryPage> {
  int _test = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          FadeWidget(
            child: IconButton(
                icon: Icon(Icons.title),
                onPressed: () {
                  setState(() {
                    _test++;
                  });
                }),
            hash: Text('test').hashCode,
            test: _test,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(),
          );
        },
      ),
    );
  }
}
