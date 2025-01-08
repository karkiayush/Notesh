import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notesh/database/db_handler.dart';
import 'package:notesh/models/note_model.dart';
import 'package:notesh/widgets/form_widget.dart';
import '../theme/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/dialog_box_widget.dart';
import '../widgets/toast_widget.dart';

class UpdateNoteScreen extends StatefulWidget {
  final NoteModel noteModel;

  const UpdateNoteScreen({super.key, required this.noteModel});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  late Color _selectedColor = noteContainerColor;
  bool _isNoteUpdating = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.noteModel.title);
    _descriptionController =
        TextEditingController(text: widget.noteModel.content);
    _selectedColor = widget.noteModel.noteContainerColor;
    super.initState();
  }

  @override
  void dispose() {
    // disposing inorder to prevent memory leaks
    _titleController!.dispose();
    _descriptionController!.dispose();
    super.dispose();
  }

  // For the color picker
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
          "Update Note",
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
            buttonIcon: Icons.check_circle_outlined,
            iconColor: iconColor,
            onTap: () {
              showDialogBoxWidget(
                context,
                title: "Save Changes?",
                height: 230,
                onTapYes: () {
                  _updateNote();
                  Navigator.pop(context);
                },
              );
            },
          ),
          SizedBox(width: 5),
        ],
      ),
      body: AbsorbPointer(
        absorbing: _isNoteUpdating,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _isNoteUpdating == true
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
                      controller: _titleController!,
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
                      controller: _descriptionController!,
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

  void _updateNote() {
    setState(() {
      _isNoteUpdating = true;
    });

    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (_titleController!.text.isEmpty) {
        ToastWidget.getMessageToast("title can't be empty");
        setState(() {
          _isNoteUpdating = false;
        });
        return;
      }

      if (_descriptionController!.text.isEmpty) {
        ToastWidget.getMessageToast("Empty note is not allowed!!");
        setState(() {
          _isNoteUpdating = false;
        });
        return;
      }

      DbHandler.updateNote(NoteModel(
        noteId: widget.noteModel.noteId,
        title: _titleController!.text,
        content: _descriptionController!.text,
        noteContainerColor: _selectedColor,
      )).then((value) {
        _isNoteUpdating = false;
        Navigator.pop(context);
      });
    });
  }
}
