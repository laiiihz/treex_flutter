import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadState();
}

class _DownloadState extends State<DownloadPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(text: '下载'),
            Tab(text: '上传'),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          ListView.builder(
            physics: MIUIScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.arrowCircleDown),
                  title: Text('test'),
                  subtitle: LinearProgressIndicator(),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.play_arrow), onPressed: () {}),
                    ],
                  ),
                ),
                actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    icon: Icons.delete,
                    color: Colors.red,
                  ),
                ],
              );
            },
            itemCount: 1,
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Text('test');
            },
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
