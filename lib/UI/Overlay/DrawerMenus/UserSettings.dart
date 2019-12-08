import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:treex_flutter/Provider/AppProvider.dart';
import 'package:treex_flutter/generated/i18n.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettingsPage> {
  File _fileAvatar;
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
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: 'userName',
                          barrierColor: Colors.black45,
                          transitionDuration: Duration(milliseconds: 200),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
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
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.dark
                                            ? Color(0xff333333)
                                            : Color(0xffdddddd),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 20),
                                          Text(
                                            '修改用户名',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          SizedBox(height: 20),
                                          TextField(),
                                          ButtonBar(
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () {},
                                                child:
                                                    Text(S.of(context).cancel),
                                              ),
                                              RaisedButton(
                                                onPressed: () {},
                                                child:
                                                    Text(S.of(context).confirm),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          context: context,
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.details),
                        title: Text(S.of(context).user_name),
                        trailing: Text(
                          provider.userName,
                        ),
                      ),
                    );
                  },
                ),
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
}
