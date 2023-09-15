import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'firebase_systems/firestore.dart';
import 'firebase_systems/firebase_connection.dart';

const List<String> list = <String>[
  'Prefere not to say',
  'Male',
  'Female',
  'Non-Binary',
]; //list of the gender options

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isVegan = false;
bool isStudent = false;

class _ProfilePageState extends State<ProfilePage> {
  XFile? profilePicture; // Image variable
  DateTime dateofbirth = DateTime.now(); // dateofbirth variable;
  DateTime? date;
  bool veganOrNot = false;
  bool studentOrNot = false;
  String dropdownValue = list.first; // dropdown Menu values
  String? mediaUrl;
  final Service _service = Service();

  uploadMedia(ImageSource source) async {
    profilePicture = await ImagePicker().pickImage(source: source);
    if (profilePicture == null) return;
    mediaUrl =
        await _service.uploadMedia(File(profilePicture!.path), "UserUniqueID");
    updateUserImage(mediaUrl.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        //making the page scrollable
        child: Column(
          children: [
            Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    alignment: Alignment.topRight,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                    iconSize: 40,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (mediaUrl != null) // if a picture is selected, show it
                Stack(alignment: AlignmentDirectional.topEnd, children: [
                  ClipRRect(
                    // making the profile picture circular
                    borderRadius: BorderRadius.circular(100),
                    child: mediaUrl == null
                    ? Image.network(mediaUrl!, // showing the picture that we get from the storage
                      width: 200, height: 200, fit: BoxFit.cover,)
                    : Image.network('https://img.freepik.com/free-icon/user_318-644324.jpg',
                    width: 200, height: 200, fit: BoxFit.cover,)
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 150, right: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(180, 67, 176, 104),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(100)),
                    width: 35,
                    height: 35,
                    child: const Icon(Icons.edit),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  const Text("Select a format to upload image"),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Gallery'),
                                  onPressed: () =>uploadMedia(ImageSource.gallery),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  child: const Text('Camera'),
                                  onPressed: () =>uploadMedia(ImageSource.camera),
                                ),
                                const SizedBox(
                                  width: 60,
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      width: 200,
                      height: 200,
                    ),
                  ),
                ])
            ]),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    //spacing
                    width: 4,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
              child: TextField(
                // text field for the name of the user
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "name",
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (String value) async {
                  updateUserName(value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
              child: TextField(
                //text field for the surname of the user
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Surname',
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (String value) async {
                  updateUserSurname(value);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
              child: TextField(
                //text field for the users nicnname
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  labelText: 'Nickname',
                ),
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (String value) async {
                  updateUserNickname(value);
                },
              ),
            ),
            const Divider(
              // spacing by using a divider
              height: 30,
              thickness: 2.5,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  //creating a button that opens the calender
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dateofbirth,
                      firstDate: DateTime(1900), //start is 20th century
                      lastDate: DateTime(2100),
                    );

                    if (newDate == null) return;

                    setState(() {
                      dateofbirth = newDate;
                      date = newDate;
                      updateUserDOB(date.toString());
                    });

                    // userDateOfBirth(context);
                    updateUserDOB(dateofbirth.toString());
                  },
                  child: const Text(
                    'Select birth of date',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${dateofbirth.year}-${dateofbirth.month}-${dateofbirth.day}', //saving the variable and writing it to the text
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, //creating a dropdown menu for the gender selection
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'Gender:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 50, 109, 53), fontSize: 20),
                  underline: Container(
                    //simple styling the texts and menu
                    height: 2,
                    color: const Color.fromARGB(255, 50, 109, 53),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      //chaning the gender on user selection
                      dropdownValue = value!;
                      updateUserGender(value);
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const Divider(
              // spacing by using a divider
              height: 30,
              thickness: 2.5,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
            Row(
                //creating two switch options for the vegan and student, yes or no questions.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //asking if the user is vegan or not, the default value is false
                  const Text(
                    'I am a Vegetarian/Vegan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Switch(
                        value: veganOrNot,
                        activeColor: Colors.green,
                        onChanged: (bool value) async {
                          setState(() {
                            veganOrNot = value;
                            isVegan = veganOrNot;
                            //changing the value if it is switched
                          });
                          updateUserVegan(value);
                        }),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                //switch option for student or not question.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I am a Student',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: studentOrNot,
                      activeColor: Colors.blue,
                      onChanged: (bool value) async {
                        setState(() {
                          //changing the value if it is changed
                          studentOrNot = value;
                          isStudent = studentOrNot;
                        });
                        updateUserStudent(
                            value); //updating the user student status
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
