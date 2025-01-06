import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notesh/database/db_handler.dart';
import 'package:notesh/models/note_model.dart';
import 'package:notesh/widgets/form_widget.dart';
import 'package:notesh/widgets/toast_widget.dart';

import '../theme/colors.dart';
import '../widgets/button_widget.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late Color _selectedColor = noteContainerColor;
  bool _isNoteCreating = false;

  @override
  void dispose() {
    // disposing inorder to prevent memory leaks
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        Color tempColor = _selectedColor;
        return AlertDialog(
          title: const Text("Pick a Color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                tempColor = color;
                debugPrint("TempColor: $tempColor");
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor = tempColor;
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Select",
                style: TextStyle(color: textColor),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          "New Note",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          ButtonWidget(
            buttonIcon: Icons.color_lens,
            iconColor: iconColor,
            onTap: _openColorPicker,
          ),
          SizedBox(width: 20),
          ButtonWidget(
            buttonIcon: Icons.save,
            iconColor: iconColor,
            onTap: _saveNotes,
          ),
          SizedBox(width: 5),
        ],
      ),
      body: AbsorbPointer(
        absorbing: _isNoteCreating,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _isNoteCreating == true
                ? CircularProgressIndicator(color: textColor, strokeWidth: 3)
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: noteContainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FormWidget(
                      controller: _titleController,
                      hintText: "Title",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: noteContainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FormWidget(
                      controller: _descriptionController,
                      hintText: "type anything.....",
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNotes() {
    setState(() {
      _isNoteCreating = true;
    });

    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (_titleController.text.isEmpty) {
        ToastWidget.getMessageToast("title can't be empty");
        setState(() {
          _isNoteCreating = false;
        });
        return;
      }

      if (_descriptionController.text.isEmpty) {
        ToastWidget.getMessageToast("Empty note is not allowed!!");
        setState(() {
          _isNoteCreating = false;
        });
        return;
      }

      DbHandler.createNote(NoteModel(
        title: _titleController.text,
        content: _descriptionController.text,
        noteContainerColor: _selectedColor,
      )).then((value) {
        _isNoteCreating = false;
        Navigator.pop(context);
      });
    });
  }
}
