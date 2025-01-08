import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppInfoWidget {
  BuildContext context;

  AppInfoWidget({required this.context});

  void showAppInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: darkGreyColor,
          child: Container(
            width: double.infinity,
            height: 380,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  "Notesh",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Notesh is a note taking apps which allows user to take notes, delete, update it and search note on the basis of note title.\n\n Notesh provide user with a feature to choose color for the note list they want. We'll be releasing major & minor update time to time, so keep yourself updated\n\n Provide us feedback of your user experience",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
