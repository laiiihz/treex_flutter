import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/LocalFile/LocalFileFunc.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/helpers/ImageHelper.dart';

class PhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoState();
}

class _PhotoState extends State<PhotoPage> {
  List<FileSystemEntity> _photosFiles = [];
  @override
  void initState() {
    super.initState();
    init() async {
      var tempDir = await getExternalStorageDirectory();
      tempDir = Directory(tempDir.path + '/pics');
      setState(() {
        _photosFiles = tempDir.listSync();
      });
    }

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: false,
            title: Text('PHOTOS'),
            expandedHeight: 200,
            flexibleSpace: Stack(
              children: <Widget>[
                _photosFiles.length != 0
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(
                          File(_photosFiles[0].path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Align(
                      alignment: Alignment.centerRight.add(Alignment(-0.2, 0)),
                      child: Hero(
                        tag: 'pics',
                        child: Icon(
                          getDisplayIcon('pics'),
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Hero(
                          tag: _photosFiles[index].path,
                          child: Image.file(
                            File(_photosFiles[index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ImageHelperPage(file: _photosFiles[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: _photosFiles.length,
            ),
          ),
        ],
      ),
    );
  }
}
