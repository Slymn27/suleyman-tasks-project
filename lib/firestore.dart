import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


CollectionReference collectionId = FirebaseFirestore.instance.collection("UserProfile");
Stream collectionStream = FirebaseFirestore.instance.collection("UserProfile").snapshots();
Stream documentStream = FirebaseFirestore.instance.collection("UserProfile").doc().snapshots();
bool isUserVegan =false;

class UserData extends StatefulWidget{
  @override
    _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData>{
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('UserProfile').snapshots();

  @override
  Widget build(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [ 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data['userName']),
                  Text(" "),
                  Text(data['userSurname']),
                ],
              ),
              Text(data['userNickname']),
              Text(data['userVegan'].toString()),
              Text(data['userStudent'].toString()),
              Text(data['userDOB']),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

Future<void> updateUserName(String newName) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userName': newName})
    .then((value) => print("Name Updated"))
    .catchError((error) => print("Failed to update name: $error"));
}

Future<void> updateUserSurname(String newSurname) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userSurname': newSurname})
    .then((value) => print("surname Updated"))
    .catchError((error) => print("Failed to update surname: $error"));
}
Future<void> updateUserNickname(String newNickname) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userNickname': newNickname})
    .then((value) => print("Nickname Updated"))
    .catchError((error) => print("Failed to update nickname: $error"));
}

Future<void> updateUserVegan(bool newVegan) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userVegan': newVegan})
    .then((value) => print("Vegan Status Updated"))
    .catchError((error) => print("Failed to update vegan status: $error"));
}

String GetUserName(String currentUserName) {
  return FirebaseFirestore.instance.collection("UserProfile").doc("JY77sv8HTXTkHay7RCt2").get().toString();
    // ({'userName': currentUserName})
    // .then((value) => print("Vegan Status Updated"))
     // .catchError((error) => print("Failed to update vegan status: $error"));
}

//collectionId.doc("JY77sv8HTXTkHay7RCt2").get().toString();
void getUserData(){
}