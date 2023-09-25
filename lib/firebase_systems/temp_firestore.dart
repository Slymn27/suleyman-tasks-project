import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:suleymankiskacproject/firebase_systems/app_state.dart';

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("UserProfile");
String id = UserInformation().userId;
DocumentReference docRef = collectionRef.doc(id);

final newUser = <String, dynamic> {
  "userName": "new user",
  "userSurname": "new user",
  "userNickname": "new user",
  "userDOB": "2000-12-31",
  "userGender": "Prefere not to say",
  "userStudent": false,
  "userVegan": false,
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
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                Text("data"),
                Text("data"),
                Text("data"),
                Text("data"),
                ],
            );
          }).toList(), //converting to list format
        );
      },
    );
  }
}

Future<DocumentReference> userId() {
  return FirebaseFirestore.instance
      .collection('UserProfile')
      .add(<String, dynamic>{
    'userId': FirebaseAuth.instance.currentUser!.uid,
  });
}

Future<void> updateUserImage(String newImage) {
  return collectionRef
      .doc("JY77sv8HTXTkHay7RCt2") // the document Id
      .update({'userImage': newImage}) //updating the new name
      .then((value) => print(
          "Profile Picture Updated")) //printing to the log that it was updated
      .catchError((error) => print(
          "Failed to update Profile Picture: $error")); //in case of error, printing the error message to the log
}

Future<void> updateUserName(String newName) {
  return collectionRef
      .doc("JY77sv8HTXTkHay7RCt2") // the document Id
      .update({'userName': newName}) //updating the new name
      .then((value) =>
          print("Name Updated")) //printing to the log that it was updated
      .catchError((error) => print(
          "Failed to update name: $error")); //in case of error, error message on the log
}

Future<void> updateUserSurname(String newSurname) {
  return collectionRef
      .doc("JY77sv8HTXTkHay7RCt4")
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