import 'dart:io';

import 'package:path_provider/path_provider.dart';

void createFolder(String folderName) async {
  final dir = await getExternalStorageDirectory();

  final path = Directory(dir.path + "/" + folderName);
  if ((!await path.exists())) {
    path.create();
  } else {
  }
}

Future<String> getAudiosFolderPath() async {
  final dir = await getExternalStorageDirectory();
  return "${dir.path}/audios";
}

Future<String> getLrcFolderPath() async {
  final dir = await getExternalStorageDirectory();
  return "${dir.path}/lrc";
}

Future<int> getFileLength(String fileNameWithPath) async {
  var file = File(fileNameWithPath);
  if ((await file.exists())) {
    return await file.length();
  } else {
    return -1;
  }
}
