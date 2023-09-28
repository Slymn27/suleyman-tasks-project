import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:suleymankiskacproject/firebase_systems/app_state.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User? curUser = auth.currentUser;

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("UserProfile");
var id = UserInformation().userId; // to get the user ID

DocumentReference docRef = collectionRef.doc(curUser!.uid);

final newUser = <String, dynamic> {
  "userName": "new user",
  "userSurname": "new user",
  "userNickname": "new user",
  "userDOB": "2000-12-31",
  "userGender": "Prefere not to say",
  "userStudent": false,
  "userVegan": false,
  "userImage": null,
  "userId" : id,
};

void userExists(){
  docRef.get().then((value) => {
    if (value.exists) {
      print("already exists")
    }
    else{
      docRef.set(newUser).onError((error, _) => print("error: $error")),
      print("created new user")
    }
  });
}

class UserData extends StatefulWidget {
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {

  final Stream<QuerySnapshot> _usersStream = collectionRef.snapshots();
  final mySnapshot = FirebaseFirestore.instance.collection("UserProfile").doc(id).get().then((value) => print("done"));
  
  @override
  Widget build(BuildContext context) { 
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text(
              'Something went wrong'); //if case of an error, printing 'someting went wrong' message
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      22)); //while waiting for the data, printing 'loading' message
        }
       return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;//get data from database
            return Column(
              children: [
                data["userImage"] == null 
                ? Image.network(// If user has no profile picture, show empty user image
                'https://img.freepik.com/free-icon/user_318-644324.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                  )
                : Image.network(
                data["userImage"],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                  ),
                  data["userNickname"] != null
                ? Text(data["userNickname"])
                : const Text("empty"),
                data["userSurname"] != null
                ? Text(data["userSurname"])
                : const Text("empty"),
                data["userName"] != null
                ? Text(data["userName"])
                : const Text("empty"),
                Text(data["userGender"]),
                data["userVegan"]
                ? const Text("Vegan")
                : const Text("Not Vegan"),
                data["userStudent"]
                ? const Text("Student")
                : const Text("Not Student"),
                ],
            );
          }).toList(), //converting to list format
        );
      },
    );
  }
}

Future<Widget> readName () async{ // ###testing if I can get the data from database ###
  final mySnapshot = await FirebaseFirestore.instance.collection("UserProfile").doc(id).get();
  if(mySnapshot.exists){
    final docData = mySnapshot.data();
    return Text(docData!['userName']);
  } 
  return Text("N/A");
}

Future<void> updateUserImage(String newImage) {
  return collectionRef
      .doc(id) // the document Id
      .update({'userImage': newImage}) //updating the new name
      .then((value) => print(
          "Profile Picture Updated")) //printing to the log that it was updated
      .catchError((error) => print(
          "Failed to update Profile Picture: $error")); //in case of error, printing the error message to the log
}

Future<void> updateUserName(String newName) {
  return collectionRef
      .doc(id) // the document Id
      .update({'userName': newName}) //updating the new name
      .then((value) =>
          print("Name Updated")) //printing to the log that it was updated
      .catchError((error) => print(
          "Failed to update name: $error")); //in case of error, error message on the log
}

Future<void> updateUserSurname(String newSurname) {
  return collectionRef
      .doc(id)
      .update({'userSurname': newSurname})
      .then((value) => print("surname Updated"))
      .catchError((error) => print("Failed to update surname: $error"));
}

Future<void> updateUserNickname(String newNickname) {
  return collectionRef
      .doc(id)
      .update({'userNickname': newNickname})
      .then((value) => print("Nickname Updated"))
      .catchError((error) => print("Failed to update nickname: $error"));
}

Future<void> updateUserGender(String newGender) {
  return collectionRef
      .doc(id)
      .update({'userGender': newGender})
      .then((value) => print("Gender Updated"))
      .catchError((error) => print("Failed to update gender: $error"));
}

Future<void> updateUserVegan(bool newVegan) {
  return collectionRef
      .doc(id)
      .update({'userVegan': newVegan})
      .then((value) => print("Vegan Status Updated"))
      .catchError((error) => print("Failed to update vegan status: $error"));
}

Future<void> updateUserStudent(bool newStudent) {
  return collectionRef
      .doc(id)
      .update({'userStudent': newStudent})
      .then((value) => print("Student Status Updated"))
      .catchError((error) => print("Failed to update student status: $error"));
}

Future<void> updateUserDOB(String newDOB) {
  List<String> splitted =
      newDOB.split(' '); //we split the time part and only use the date portion
  return collectionRef
      .doc(id)
      .update({
        'userDOB': splitted[0]
      }) //index 0 is the date part, index 1 is the time part, we select index 0 to print
      .then((value) => print("Birth date Updated"))
      .catchError((error) => print("Failed to Birth date: $error"));
}

String yesnoanswer =
    ""; //the variable for answering the vegan and student questions

String isUserVegan(bool thedata) {
  //getting the vegan status from the database
  if (thedata) {
    yesnoanswer = "yes"; //if true, return yes
    return yesnoanswer;
  } else {
    yesnoanswer = "no"; //if false, return no
    return yesnoanswer;
  }
}

String isUserStudent(bool thedata) {
  //getting the student status from the database
  if (thedata) {
    yesnoanswer = "yes"; //if true, return yes
    return yesnoanswer;
  } else {
    yesnoanswer = "no"; //if false, return no
    return yesnoanswer;
  }
}

// https://flutterassets.com/split-string-in-flutter-examples/ --> splitting string