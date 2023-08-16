import 'package:flutter/material.dart';


Widget customButton({ //creating a custom button for profile picture section
  required String titleOfbutton, //the widget takes a string for the title, an icon name for the icon -->
  required IconData iconOfbutton,// --> and a funciton to do its stuff
  required VoidCallback onClickFunction,
}) {
  return Container(//simple container for the button
    width: 180,
    child: ElevatedButton(
        onPressed: onClickFunction,
        child: Row(
          children: [
            Icon(iconOfbutton), //showing the icon that has been passed to the function
            const SizedBox(width: 10),
            Text(titleOfbutton),//writing the string that has been passeed to the function
          ],
        )),
  );
}

