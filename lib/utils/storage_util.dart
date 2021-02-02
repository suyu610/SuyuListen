import 'dart:io';

import 'package:path_provider/path_provider.dart';

void createFolder(String folderName) async {
  final dir = await getExternalStorageDirectory();

  final path = Directory(dir.path + "/" + folderName);
  if ((!await path.exists())) {
    print("创建目录成功");
    path.create();
  } else {
    print(path.path);
    print("目录已存在");
  }
}

Future<String> getAudiosFolderPath() async {
  final dir = await getExternalStorageDirectory();
  return "${dir.path}/audios";
}

Future<int> getFileLength(String fileNameWithPath) async {
  var file = File(fileNameWithPath);
  if ((await file.exists())) {
    return await file.length();
  } else {
    return -1;
  }
}
