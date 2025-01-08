import 'package:flutter/material.dart';
import 'package:notesh/database/db_handler.dart';
import 'package:notesh/models/note_model.dart';
import 'package:notesh/screens/search_note_screen.dart';
import 'package:notesh/screens/update_note_screen.dart';
import 'package:notesh/theme/colors.dart';
import 'package:notesh/widgets/app_info_widget.dart';
import 'package:notesh/widgets/button_widget.dart';
import 'package:notesh/widgets/dialog_box_widget.dart';
import 'package:notesh/widgets/single_note_widget.dart';
import 'create_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppInfoWidget appInfoWidget = AppInfoWidget(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          "Notesh",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          ButtonWidget(
            buttonIcon: Icons.search,
            iconColor: iconColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchNoteScreen()),
              );
            },
          ),
          SizedBox(width: 20),
          ButtonWidget(
            buttonIcon: Icons.info_rounded,
            iconColor: iconColor,
            onTap: () {
              appInfoWidget.showAppInfo();
            },
          ),
          SizedBox(width: 5),
        ],
      ),

      // Wrapping up the listview.builder with stream builder that received List data of NoteModel type
      body: StreamBuilder<List<NoteModel>>(
        // stream need the function to retrieve the list of note model
        stream: DbHandler.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading notes: ${snapshot.error}",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No notes available",
                style: TextStyle(color: textColor, fontSize: 20),
              ),
            );
          }

          // It gives us the list of NoteModel
          final notes = snapshot.data;
          return ListView.builder(
            itemCount: notes?.length,
            itemBuilder: (context, index) {
              return SingleNoteWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateNoteScreen(noteModel: notes[index]),
                    ),
                  );
                },
                onLongPress: () {
                  showDialogBoxWidget(
                    context,
                    title: "Confirm to delete the note!",
                    height: 230,
                    onTapYes: () {
                      DbHandler.deleteNote(notes[index].noteId!);
                      Navigator.pop(context);
                    },
                  );
                },
                title: notes?[index].title,
                body: notes?[index].content,
                color: notes![index].noteContainerColor,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateNoteScreen()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(Icons.add),
      ),
    );
  }
}
