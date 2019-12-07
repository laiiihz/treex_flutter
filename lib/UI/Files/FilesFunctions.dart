import 'dart:io';
import 'package:intl/intl.dart';

String getFileShortPath(FileSystemEntity fileSystemEntity) {
  return fileSystemEntity.path
      .substring(fileSystemEntity.parent.path.length + 1);
}

int getSubFileLength(FileSystemEntity fileSystemEntity) {
  return Directory(fileSystemEntity.path).listSync().length;
}

bool isDirectory(FileSystemEntity fileSystemEntity) {
  return FileSystemEntity.isDirectorySync(fileSystemEntity.path);
}

DateTime getFileCreateTime(FileSystemEntity fileSystemEntity) {
  return fileSystemEntity.statSync().modified;
}

String fileCreateTimeFormat(FileSystemEntity fileSystemEntity) {
  return DateFormat('yyyy-MM-dd hh:mm:ss').format(getFileCreateTime(fileSystemEntity));
}
