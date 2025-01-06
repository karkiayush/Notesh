import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesh/models/note_model.dart';
import 'package:notesh/widgets/toast_widget.dart';

class DbHandler {
  static Future<void> createNote(NoteModel note) async {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
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
      await noteCollection.doc(id).set(newNote);
    } catch (e) {
      // Displaying error message
      ToastWidget.getErrorToast(e);
    }
  }

  // Read note
  static Stream<List<NoteModel>> getNotes() {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
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
    final noteCollection = FirebaseFirestore.instance.collection("notes");
    final newNote = NoteModel(
      noteId: note.noteId,
      title: note.title,
      content: note.content,
      noteContainerColor: note.noteContainerColor,
    ).toDocument();

    try {
      await noteCollection.doc(note.noteId).update(newNote);
    } catch (e) {
      ToastWidget.getErrorToast(e);
    }
  }

  // Delete note
  static Future<void> deleteNote(String id) async {
    final noteCollection = FirebaseFirestore.instance.collection("notes");
    try {
      await noteCollection.doc(id).delete();
    } catch (e) {
      ToastWidget.getErrorToast(e);
    }
  }
}
