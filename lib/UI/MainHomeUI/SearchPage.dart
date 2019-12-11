import 'package:flutter/material.dart';

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
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: <Widget>[
        SliverList(delegate: SliverChildListDelegate([Text('test')])),
        SliverList(delegate: SliverChildListDelegate([Text('test')])),
        SliverList(delegate: SliverChildListDelegate([Text('test')])),
      ],
    );
  }
}


