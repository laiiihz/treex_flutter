import 'package:flutter/material.dart';
import 'package:treex_flutter/generated/i18n.dart';

class NetworkSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkSettingsState();
}

class _NetworkSettingsState extends State<NetworkSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(S.of(context).network_settings),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              labelText: S.of(context).ip_address,
                              hintText: '127.0.0.1',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: S.of(context).port,
                              hintText: 'default:8080',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.flash_on),
                      onPressed: () {},
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text(S.of(context).save),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
