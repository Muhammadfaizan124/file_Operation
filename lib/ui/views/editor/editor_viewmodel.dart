import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

class EditorViewmodel extends BaseViewModel {
  BuildContext? context;
  final codeController = TextEditingController();
  final fileNameController = TextEditingController();
  String selectedLanguage = "Python";

  List<String> languages = [
    'C',
    'C++',
    'Python',
    'JavaScript',
    'HTML',
    'CSS',
    'TypeScript',
  ];

  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName.txt');
  }

  Future<void> saveFile(context) async {
    print("runing");
    try {
      final fileName = fileNameController.text.trim();
      final editor = codeController.text;
      if (fileName.isEmpty && editor.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('editor or file nname is empty.'),
          ),
        );
      } else {
        final file = await localFile(fileName);
        await file.writeAsString(codeController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File saved'),
          ),
        );
        fileNameController.clear();
        codeController.clear();
      }
    } catch (e) {
      print("HERE IS THE ERROR FROM SAVE FILE $e");
    }
  }

  Future<void> loadFile(context) async {
    try {
      final fileName = fileNameController.text.trim();
      if (fileName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter file name'),
          ),
        );
      }

      final file = await localFile(fileName);
      if (await file.exists()) {
        codeController.text = await file.readAsString();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File loaded'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File not found'),
          ),
        );
      }
    } catch (e) {
      print("HERE IS THE ERROR FROM LOAD FILE $e");
    }
  }

  changeLanguage(value) {
    selectedLanguage = value;
    rebuildUi();
  }
}
