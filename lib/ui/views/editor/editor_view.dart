import 'package:code_editor/ui/views/editor/editor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditorView extends StatelessWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EditorViewmodel(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: viewmodel.selectedLanguage,
                    isExpanded: true,
                    onChanged: (value) {
                      viewmodel.changeLanguage(value);
                    },
                    items: viewmodel.languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: viewmodel.fileNameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter file name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TextField(
                      controller: viewmodel.codeController,
                      decoration: const InputDecoration(
                        labelText: 'Write your code here',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                          onPressed: () {
                            viewmodel.saveFile(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.folder_open),
                          label: const Text('Load'),
                          onPressed: () {
                            viewmodel.loadFile(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
