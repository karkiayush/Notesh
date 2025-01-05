import 'package:flutter/material.dart';
import 'package:notesh/screens/update_note_screen.dart';
import 'package:notesh/theme/colors.dart';
import 'package:notesh/widgets/button_widget.dart';
import 'package:notesh/widgets/dialog_box_widget.dart';
import 'package:notesh/widgets/single_note_widget.dart';

import 'create_note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            buttonIcon: Icons.search_sharp,
            iconColor: iconColor,
          ),
          SizedBox(width: 20),
          ButtonWidget(
            buttonIcon: Icons.info_rounded,
            iconColor: iconColor,
          ),
          SizedBox(width: 5),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SingleNoteWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateNoteScreen(),
                ),
              );
            },
            onLongPress: () {
              showDialogBoxWidget(
                context,
                title: "Confirm to delete the note!",
                height: 230,
                onTapYes: () {
                  Navigator.pop(context);
                },
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
