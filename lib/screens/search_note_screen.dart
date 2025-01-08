import 'package:flutter/material.dart';
import 'package:notesh/database/db_handler.dart';
import 'package:notesh/models/note_model.dart';
import 'package:notesh/theme/colors.dart';
import 'package:notesh/widgets/form_widget.dart';
import 'package:notesh/widgets/single_note_widget.dart';

class SearchNoteScreen extends StatefulWidget {
  const SearchNoteScreen({super.key});

  @override
  State<SearchNoteScreen> createState() => _SearchNoteScreenState();
}

class _SearchNoteScreenState extends State<SearchNoteScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NoteModel> _filteredNotes = [];
  List<NoteModel> _allNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await DbHandler.getNotes().first; // Retrieve all notes once
    setState(() {
      _allNotes = notes;
    });
  }

  void _filterNotes(String query) {
    setState(() {
      _filteredNotes = _allNotes
          .where(
            (note) => note.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          "Search Notes",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormWidget(
              controller: _searchController,
              hintText: "Enter note title",
              fontSize: 18,
              maxLines: 1,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _filterNotes(_searchController.text);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(appBarColor),
            ),
            child: Text(
              "Search",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            child: _filteredNotes.isEmpty
                ? Center(
                    child: Text(
                      "No notes found",
                      style: TextStyle(fontSize: 20, color: textColor),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = _filteredNotes[index];
                      return SingleNoteWidget(
                        title: note.title,
                        body: note.content,
                        color: note.noteContainerColor,
                        onTap: () {
                          // Navigate to update note screen or perform other actions
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
