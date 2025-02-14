import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SingleNoteWidget extends StatelessWidget {
  final String? title;
  final String? body;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SingleNoteWidget({
    super.key,
    this.title,
    this.body,
    this.color,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? noteContainerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title != null ? title! : "Title",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              body != null ? body! : "some dummy text for body",
              style: TextStyle(
                fontSize: 17,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
