import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

loadJsonFromAssets(String path) async {
  String data = await rootBundle.loadString(path);
  return json.decode(data);
}

class Repository {
  String? initialAssetFile;
  String? localFilename;

  Repository({required this.initialAssetFile, required this.localFilename});
  Repository.appcofig() {
    initialAssetFile = 'assets/config/app.json';
    localFilename = 'app.json';
  }

  Future<File> _initializeFile() async {
    final localDirectory = await getApplicationDocumentsDirectory();

    final file = File(localDirectory.path.toString() + '/' + localFilename!);

    if (!await file.exists()) {
      final initialContent = await rootBundle.loadString(initialAssetFile!);

      await file.create();

      await file.writeAsString(initialContent);
    }

    return file;
  }

  Future<String> readFile() async {
    final file = await _initializeFile();

    return await file.readAsString();
  }

  Future<Map<String, dynamic>> readFileAndReturnMap() async {
    final file = await _initializeFile();

    return await jsonDecode(await file.readAsString());
  }

  Future<void> writeToFile(String data) async {
    final file = await _initializeFile();
    await file.writeAsString(data);
  }
}
