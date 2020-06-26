import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

const String JSON_FILE_COUNTRY = "country.json";
const String JSON_FILE_COVID = "covid.json";
const String BOOKMARKED_COUNTRY = "bookmark.txt";

File getFile(String directory, String fileName) {
  return new File(directory + '/' + fileName);
}

bool isFileExisted(File file) {
  return file.existsSync();
}

String readDataFromFile(File file) {
  return file.readAsStringSync();
}

void writeDataToFile(File file, String data) {
  file.writeAsStringSync(data);
}

Future<String> getDirPath() async {
  String path = "";
  await getApplicationDocumentsDirectory().then((Directory directory) {
    path = directory.path;
  });
  return Future.value(path);
}

Future<List> getDataFromFile(String fileName) async {
  String dirPath = await getDirPath();
  File file = getFile(dirPath, fileName);
  if (isFileExisted(file)) {
    return Future.value([true, readDataFromFile(file)]);
  } else {
    return Future.value([false]);
  }
}

Future<bool> setDataToFile(String fileName, String data) async {
  String dirPath = await getDirPath();
  File file = getFile(dirPath, fileName);
  try {
    if (!isFileExisted(file)) file.createSync(recursive: true);
    writeDataToFile(file, data);
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}

void deleteDataFile(String fileName) async {
  String dirPath = await getDirPath();
  File file = getFile(dirPath, fileName);
  if (isFileExisted(file)) file.deleteSync();
}

void deleteDataOfCountryCached() {
  deleteDataFile(JSON_FILE_COUNTRY);
}

Future<List> getDataOfCountryCached() async {
  return await getDataFromFile(JSON_FILE_COUNTRY);
}

Future<bool> setDataToCountryCached(String data) async {
  return await setDataToFile(JSON_FILE_COUNTRY, data);
}

void deleteDataOfCovidCached() {
  deleteDataFile(JSON_FILE_COVID);
}

Future<List> getDataOfCovidCached() async {
  return await getDataFromFile(JSON_FILE_COVID);
}

Future<bool> setDataToCovidCached(String data) async {
  return await setDataToFile(JSON_FILE_COVID, data);
}

Future<String> readAssetsAboutCovidFile() async {
  return rootBundle.loadString('assets/files/aboutCovid.txt');
}

void deleteDataOfBookMark() {
  deleteDataFile(BOOKMARKED_COUNTRY);
}

Future<List> getDataOfBookmark() async {
  return await getDataFromFile(BOOKMARKED_COUNTRY);
}

Future<bool> setDataToBookmark(String data) async {
  return await setDataToFile(BOOKMARKED_COUNTRY, data);
}

