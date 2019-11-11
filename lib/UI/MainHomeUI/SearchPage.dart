import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';

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
    final provider = Provider.of<AppProvider>(context);
    return provider.nightModeOn ? ThemeData.dark() : super.appBarTheme(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(query),
          ),
        );
      },
      itemCount: 5,
    );
  }
}
