import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/generated/i18n.dart';
import 'package:treex_flutter/widget/MIUISettingsDialog.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettingsPage> {
  File _fileAvatar;
  TextEditingController _userNameEditor = TextEditingController();
  TextEditingController _phoneEditor = TextEditingController();
  TextEditingController _emailEditor = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _userNameEditor.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<AppProvider>(context);
      _userNameEditor.text = provider.userName;
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
            pinned: true,
            centerTitle: true,
            title: Text(S.of(context).user_settings),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/img/mountain.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.camera),
                                  onPressed: () {
                                    ImagePicker.pickImage(
                                            source: ImageSource.camera)
                                        .then((avatar) {
                                      setState(() {
                                        _fileAvatar = avatar;
                                      });
                                    });
                                  },
                                  iconSize: 50,
                                ),
                                IconButton(
                                  icon: Icon(Icons.insert_photo),
                                  onPressed: () {
                                    ImagePicker.pickImage(
                                            source: ImageSource.gallery)
                                        .then((avatar) {
                                      setState(() {
                                        _fileAvatar = avatar;
                                      });
                                      print(_fileAvatar.length());
                                    });
                                  },
                                  iconSize: 50,
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(S.of(context).set_an_avatar),
                    trailing: Hero(
                      tag: 'user_avatar',
                      child: CircleAvatar(
                        backgroundImage:
                            _fileAvatar == null ? null : FileImage(_fileAvatar),
                        child: _fileAvatar == null
                            ? Text(provider.userName[0])
                            : SizedBox(),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showTextFiledDialog(
                      context: context,
                      name: 'userName',
                      title: '设置用户名',
                      confirm: () {},
                      textEditingController: _userNameEditor,
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.details),
                    title: Text(S.of(context).user_name),
                    trailing: Text(
                      provider.userName,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showTextFiledDialog(
                      context: context,
                      name: 'phoneNumber',
                      title: '设置手机号',
                      confirm: () {},
                      textEditingController: _phoneEditor,
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text(S.of(context).phone_number),
                    trailing: Text(
                      '', //TODO phone number
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showMIUIConfirmDialog(
                        context: context,
                        child: Text('test'),
                        title: S.of(context).new_folder,
                        confirm: () {},
                      );
                    }),
                SizedBox(
                  height: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showTextFiledDialog({
    @required BuildContext context,
    @required String name,
    @required String title,
    @required VoidCallback confirm,
    @required TextEditingController textEditingController,
  }) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: name,
      barrierColor: Colors.black45,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Color(0xff333333)
                        : Color(0xffdddddd),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        title,
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: textEditingController,
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(S.of(context).cancel),
                          ),
                          RaisedButton(
                            onPressed: confirm,
                            child: Text(S.of(context).confirm),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondAnimation, child) {
        var offsetTween =
            Tween<Offset>(begin: Offset(0, 0.4), end: Offset(0, 0));
        var offsetAnimation = animation.drive(offsetTween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      context: context,
    );
  }
}
