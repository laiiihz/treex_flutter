import 'package:flutter/material.dart';
import 'package:treex_flutter/widget/SingleBlock.dart';

class FilesUIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesUIState();
}

class _FilesUIState extends State<FilesUIPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return SingleBlockWidget(icon: Icons.add_to_home_screen, text: 'test', color: Colors.pink);
            },
          ),
        ),
      ],
    );
  }
}
