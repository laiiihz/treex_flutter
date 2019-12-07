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
                        Scaffold.of(context)
                            .showBottomSheet((BuildContext context) {
                          return Card(
                            child: TextField(),
                          );
                        });
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
