import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? noteId;
  final String title;
  final String content;
  final Color noteContainerColor;

  NoteModel({
    this.noteId,
    required this.title,
    required this.content,
    required this.noteContainerColor,
  });

  // factory constructor convert the document into dart object
  factory NoteModel.fromSnapshot(
      // DocumentSnapshot<Map<String, dynamic>> snapshot,
      DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      noteId: data["id"],
      title: data["title"],
      content: data["content"],
      noteContainerColor: Color(data["noteContainerColor"]),
    );
  }

  // Convert the data from dart obj to document to store in cloud firestore
  Map<String, dynamic> toDocument() {
    return {
      "id": noteId,
      "title": title,
      "content": content,
      "noteContainerColor": noteContainerColor.value,
    };
  }
}
