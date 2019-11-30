import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/Document.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/Movie.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/MusicList.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/NormalFiles.dart';
import 'package:treex_flutter/UI/MainHomeUI/Pages/SingleTypeController/Photo.dart';

final Map<String, IconData> _displayIcons = {
  'music': Icons.library_music,
  'movies': Icons.movie,
  'pics': Icons.image,
  'docs': Icons.insert_drive_file,
  'others': Icons.folder_open,
};
final Map<String, String> _displayName = {
  'music': 'MUSIC',
  'movies': 'MOVIES',
  'pics': 'PHOTOS',
  'docs': 'DOCUMENTS',
  'others': 'OTHERS',
};
final Map<String, Color> _displayColor = {
  'music': Colors.deepOrange,
  'movies': Colors.blueGrey,
  'pics': Colors.lightGreen,
  'docs': Colors.blue,
  'others': Colors.yellow,
};

final Map<String, Widget> _namedPagesOnFileTypes = {
  'music': MusicListPage(),
  'movies': MoviePage(),
  'pics': PhotoPage(),
  'docs': DocumentPage(),
  'others': NormalFilesPage(),
};

goToFileTypesPage(BuildContext context, String name) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => _namedPagesOnFileTypes[name],
    ),
  );
}

String getDisplayName(
  String name,
) {
  return _displayName[name];
}

IconData getDisplayIcon(String name) {
  return _displayIcons[name];
}

Color getDisplayColor(String name) {
  return _displayColor[name];
}

String getFileShortName(FileSystemEntity fileSystemEntity) {
  return fileSystemEntity.path
      .substring(fileSystemEntity.parent.path.length + 1);
}

int getUnderFileLength(FileSystemEntity fileSystemEntity) {
  return Directory(fileSystemEntity.path).listSync().length;
}

bool getFileIsDir(FileSystemEntity fileSystemEntity) {
  return FileSystemEntity.isDirectorySync(fileSystemEntity.path);
}

IconData getFileOrDirIcon(FileSystemEntity fileSystemEntity) {
  if (getFileIsDir(fileSystemEntity)) {
    return Icons.folder;
  } else {
    return Icons.insert_drive_file;
  }
}
