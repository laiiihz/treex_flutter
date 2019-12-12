import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/Files/FilesStructure.dart';
import 'package:treex_flutter/widget/RoundIconButton.dart';

class ShareFilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShareFilesState();
}

class _ShareFilesState extends State<ShareFilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('共享云盘'),
        centerTitle: true,
      ),
      body: FilesStructurePage(
        prefix: Container(),
        pathList: Container(),
        suffix:
            RoundIconButtonWidget(onPress: () {}, icon: Icon(Icons.grid_on)),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 40),
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemBuilder: (BuildContext context, int index) {
            return Text('test');
          },
        ),
      ),
    );
  }
}
