import 'package:flutter/material.dart';

class SingleFileListTileWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleFileListTileState();
}

class _SingleFileListTileState extends State<SingleFileListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(Icons.folder),
        title: Text('test folder'),
      ),
      onTap: () {},
    );
  }
}
