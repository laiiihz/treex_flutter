import 'dart:io';

import 'package:flutter/material.dart';

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
String getDisplayName(String name) {
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
