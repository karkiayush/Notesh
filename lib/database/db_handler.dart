import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notesh/models/note_model.dart';

class DbHandler {
  static final noteCollection = FirebaseFirestore.instance.collection("notes");

  static Future<void> createNote(NoteModel note) async {
    final id = noteCollection.doc().id;
    // Creating a document from obtained data
    final newNote = NoteModel(
      noteId: id,
      title: note.title,
      content: note.content,
      noteContainerColor: note.noteContainerColor,
    ).toDocument();

    // Create note
    try {
      noteCollection.doc(id).set(newNote);
    } catch (e) {
      // Displaying error message
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16,
      );
    }
  }

  // Read note
  static Stream<List<NoteModel>> getNotes() {
    return noteCollection.snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return NoteModel.fromSnapshot(doc);
          },
        ).toList();
      },
    );
  }

// Update note
  static Future<void> updateNote(NoteModel note) async {
    final newNote = NoteModel(
      noteId: note.noteId,
      title: note.title,
      content: note.content,
      noteContainerColor: note.noteContainerColor,
    ).toDocument();

    try {
      await noteCollection.doc(note.noteId).update(newNote);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16,
      );
    }
  }

  // Delete note
  static Future<void> deleteNote(String id) async {
    try {
      await noteCollection.doc(id).delete();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16,
      );
    }
  }
}
