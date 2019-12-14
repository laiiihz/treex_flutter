import 'package:flutter/material.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/utils/NetUtil.dart';

class NetworkSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NetworkSettingsState();
}

class _NetworkSettingsState extends State<NetworkSettingsPage> {
  TextEditingController _ipAddrController = TextEditingController();
  TextEditingController _portController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    String _ipAddrStringTemp;
    String _ipPortStringTemp;
    _getShared() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      _ipAddrStringTemp = sharedPreferences.getString('net_addr');
      _ipPortStringTemp = sharedPreferences.getString('net_port');
    }

    _getShared().then((_) {
      setState(() {
        _ipAddrController.text = _ipAddrStringTemp;
        _portController.text = _ipPortStringTemp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
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
                            controller: _ipAddrController,
                            decoration: InputDecoration(
                              labelText: S.of(context).ip_address,
                              hintText: '127.0.0.1',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _portController,
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
                    Builder(builder: (BuildContext context) {
                      return IconButton(
                        icon: AnimatedCrossFade(
                          firstChild: Icon(Icons.flash_on),
                          secondChild: Padding(
                            padding: EdgeInsets.all(5),
                            child: CircularProgressIndicator(),
                          ),
                          crossFadeState: _isLoading
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 300),
                        ),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          checkConnectionBuild().then((value) {
                            setState(() {
                              _isLoading = false;
                            });
                            if (value) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S.of(context).connect_success),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S.of(context).connect_fail),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          });
                        },
                      );
                    }),
                    Builder(builder: (BuildContext context) {
                      return RaisedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () {
                                saveToShared() async {
                                  SharedPreferences shared =
                                      await SharedPreferences.getInstance();
                                  shared.setString(
                                      'net_addr', _ipAddrController.text);
                                  shared.setString(
                                      'net_port', _portController.text);
                                }

                                setState(() {
                                  _isLoading = true;
                                });
                                checkConnectionBuild().then((value) {
                                  if (value) {
                                    saveToShared().then((_) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      provider.setIPAndPort(
                                          'http://${_ipAddrController.text}:${_portController.text}');
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('保存成功'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    });
                                  } else {
                                    showMIUIConfirmDialog(
                                      context: context,
                                      cancelString: S.of(context).cancel,
                                      confirmString: S.of(context).confirm,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(_ipAddrController.text),
                                          Text(_portController.text),
                                        ],
                                      ),
                                      title: '连接失败，是否继续保存?',
                                      cancel: () {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      },
                                      confirm: () {
                                        saveToShared().then((_) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          provider.setIPAndPort(
                                              'http://${_ipAddrController.text}:${_portController.text}');
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('保存成功'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    );
                                  }
                                });
                              },
                        label: Text(S.of(context).save),
                        icon: Icon(Icons.done),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> checkConnectionBuild() async {
    return CheckConnectionUtil(
            serverPrefix: '${_ipAddrController.text}:${_portController.text}')
        .check();
  }
}
