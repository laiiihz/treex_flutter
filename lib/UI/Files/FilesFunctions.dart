import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

String getFileShortPath(FileSystemEntity fileSystemEntity) {
  return fileSystemEntity.path
      .substring(fileSystemEntity.parent.path.length + 1);
}

String getFileSuffix(FileSystemEntity fileSystemEntity) {
  int index = getFileShortPath(fileSystemEntity).indexOf('.');
  if (index == -1) {
    return '';
  } else {
    return getFileShortPath(fileSystemEntity).substring(index + 1);
  }
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

DateTime getFileChangedTime(FileSystemEntity fileSystemEntity) {
  return fileSystemEntity.statSync().changed;
}

DateTime getFileAccessedTime(FileSystemEntity fileSystemEntity) {
  return fileSystemEntity.statSync().accessed;
}

String fileCreateTimeFormat(FileSystemEntity fileSystemEntity) {
  return DateFormat('yyyy-MM-dd hh:mm:ss')
      .format(getFileCreateTime(fileSystemEntity));
}

String fileChangedTimeFormat(FileSystemEntity fileSystemEntity) {
  return DateFormat('yyyy-MM-dd hh:mm:ss')
      .format(getFileCreateTime(fileSystemEntity));
}

String fileAccessedTimeFormat(FileSystemEntity fileSystemEntity) {
  return DateFormat('yyyy-MM-dd hh:mm:ss')
      .format(getFileCreateTime(fileSystemEntity));
}

List<FileSystemEntity> fileFilterDirOrFile(List<FileSystemEntity> files) {
  List<FileSystemEntity> dirsTemp = [];
  List<FileSystemEntity> filesTemp = [];
  for (int i = 0; i < files.length; i++) {
    if (isDirectory(files[i])) {
      dirsTemp.add(files[i]);
    } else {
      filesTemp.add(files[i]);
    }
  }
  return dirsTemp + filesTemp;
}

List<FileSystemEntity> fileHiddenDisplay({
  List<FileSystemEntity> files,
  bool hidden = true,
}) {
  if (hidden) {
    List<FileSystemEntity> filtered = [];
    for (int i = 0; i < files.length; i++) {
      if (getFileShortPath(files[i])[0] != '.') filtered.add(files[i]);
    }
    return filtered;
  } else
    return files;
}

List<FileSystemEntity> fileFilterA2Z(List<FileSystemEntity> files) {
  List<FileSystemEntity> sorted = files;
  sorted.sort((a, b) {
    String aName = getFileShortPath(a).toLowerCase();
    String bName = getFileShortPath(b).toLowerCase();
    List<int> aCode = aName.codeUnits;
    List<int> bCode = bName.codeUnits;
    for (int i = 0; i < aName.length; i++) {
      if (bName.length <= i) return 1;
      if (aCode[i] > bCode[i])
        return 1;
      else if (aCode[i] < bCode[i]) return -1;
    }
    return 0;
  });
  return sorted;
}

Future deleteFile(FileSystemEntity fileSystemEntity) async {
  if (isDirectory(fileSystemEntity)) {
    Directory nowDir = fileSystemEntity;
    await _deleteFileInside(nowDir);
    return;
  } else {
    await fileSystemEntity.delete();
    return;
  }
}

Future<int> calculateFiles(FileSystemEntity fileSystemEntity) async {
  return compute(_countFileInside, fileSystemEntity);
}

Future<int> calculateDirs(FileSystemEntity fileSystemEntity) async {
  return compute(_countDirInside, fileSystemEntity);
}

Future<Map<String, int>> countFileSize(
    FileSystemEntity fileSystemEntity) async {
  if (!isDirectory(fileSystemEntity)) {
    return {};
  } else {
    int fileSizeTemp = await calculateFiles(fileSystemEntity);
    int dirSizeTemp = await calculateDirs(fileSystemEntity);
    return {
      'file': fileSizeTemp,
      'dir': dirSizeTemp,
    };
  }
}

int _countFileInside(FileSystemEntity fileSystemEntity) {
  List<FileSystemEntity> files = (fileSystemEntity as Directory).listSync();
  int size = 0;
  files.forEach((file) {
    if (!isDirectory(file)) {
      size = size + 1;
    } else {
      size = size + _countFileInside(file);
    }
  });
  return size;
}

int _countDirInside(FileSystemEntity fileSystemEntity) {
  List<FileSystemEntity> dirs = (fileSystemEntity as Directory).listSync();
  int size = 0;
  dirs.forEach((dir) {
    if (isDirectory(dir)) {
      size = size + 1;
      size = size + _countDirInside(dir);
    }
  });
  return size;
}

_deleteFileInside(FileSystemEntity fileSystemEntity) async {
  var files = (fileSystemEntity as Directory).listSync();
  if (files.length == 0) {
    fileSystemEntity.deleteSync();
    return;
  } else {
    files.forEach((file) {
      if (isDirectory(file)) {
        _deleteFileInside(file);
      } else {
        file.deleteSync();
      }
    });

    fileSystemEntity.deleteSync();
  }
}

final Map<String, IconData> iconStringMap = {
  '': FontAwesomeIcons.solidFile,
  'jpg': FontAwesomeIcons.solidFileImage,
  'png': FontAwesomeIcons.solidFileImage,
  'webp': FontAwesomeIcons.solidFileImage,
  'mp4': FontAwesomeIcons.solidFileVideo,
};

String getLengthString(int length) {
  if (length < 1024) {
    return '${length}B';
  } else if (length < (1024 * 1024)) {
    return '${(length / 1024).toStringAsFixed(2)}KB';
  } else if (length < (1024 * 1024 * 1024)) {
    return '${(length / 1024 / 1024).toStringAsFixed(2)}MB';
  } else {
    return '${(length / 1024 / 1024 / 1024).toStringAsFixed(2)}GB';
  }
}
