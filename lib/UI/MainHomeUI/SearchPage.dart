import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/UI/Files/FilesFunctions.dart';
import 'package:treex_flutter/generated/i18n.dart';

class SearchPage extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Text('test');
      },
      itemCount: 5,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ThemeData.dark()
        : super.appBarTheme(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    List<FileSystemEntity> list =
        Directory(provider.nowDirectory.path).listSync();
    List<FileSystemEntity> display = [];
    for (var i in list) {
      if (getFileShortPath(i).contains(query)) display.add(i);
    }

    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              S.of(context).local_files,
              style: TextStyle(fontSize: 25),
            ),
            trailing: Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(display.length.toString()),
              ),
            ),
          ),
        ),
        display.length == 0
            ? SliverToBoxAdapter(
                child: ListTile(
                  title: Text('没有搜索结果'),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Text(getFileShortPath(display[index])),
                    );
                  },
                  childCount: display.length < 10 ? display.length : 10,
                ),
              ),
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              S.of(context).cloud_files,
              style: TextStyle(fontSize: 25),
            ),
            trailing: Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text('0'),
              ),
            ),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([Text('')])),
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              S.of(context).share_folder,
              style: TextStyle(fontSize: 25),
            ),
            trailing: Card(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text('0'),
              ),
            ),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([Text('')])),
      ],
    );
  }
}
