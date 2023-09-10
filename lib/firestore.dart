import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference collectionId = FirebaseFirestore.instance.collection("UserProfile");
final storageRef = FirebaseStorage.instance.ref();
String storagePath = "";
final pathRef = storageRef.child(storagePath);

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
          return Text('Something went wrong');//if case of an error, printing 'someting went wrong' message
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22));//while waiting for the data, printing 'loading' message
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          storagePath = data['userImage'];
          //final imageRef = storageRef.child(storagePath);
          //const imageSize = 3 * 1024 * 1024;
          final image = getURL(storagePath);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const SizedBox(
                  width: double.infinity, height: 20,
                ),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    (data['userImage']!= null) 
                    ? ClipRRect(
                    // making the profile picture circular
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(image),
                      )
                    :ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.greenAccent,
                        width: 200,
                        height: 200,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: double.infinity, height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, //getting the name from the dataset
                children: [const Text('Name: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text(data['userName'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),
                    ),
                ],
              ),  //getting the name from the dataset
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('Surname: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text(data['userSurname'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),
                    ),
                ],
              ),//getting the name from the dataset
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('Nickame: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text(data['userNickname'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),
                    ),
                ],
              ),//getting the name from the dataset
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('Gender: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text(data['userGender'],style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,)
                    ),
                ],
              ),//getting the name from the dataset
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text("Vegan: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text(isUserVegan(data['userVegan']),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text("Student: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text(isUserStudent(data['userStudent']),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text("Birth Day: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text((data['userDOB']),style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,)),
                ],
              ),
              ],
            );
          }).toList(),//converting to list format
        );
      },
    );
  }
}

String getURL(pathRef){
  final imageURL = storageRef.child(pathRef).getDownloadURL().toString();
  return imageURL;
}

Future<void> updateUserImage(String newImage) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")// the document Id
    .update({'userImage': newImage}) //updating the new name
    .then((value) => print("Profile Picture Updated"))//printing to the log that it was updated
    .catchError((error) => print("Failed to update Profile Picture: $error"));//in case of error, printing the error message to the log
}

Future<void> updateUserName(String newName) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")// the document Id
    .update({'userName': newName}) //updating the new name
    .then((value) => print("Name Updated"))//printing to the log that it was updated
    .catchError((error) => print("Failed to update name: $error"));//in case of error, printing the error message to the log
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

Future<void> updateUserGender(String newGender) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userGender': newGender})
    .then((value) => print("Gender Updated"))
    .catchError((error) => print("Failed to update gender: $error"));
}

Future<void> updateUserVegan(bool newVegan) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userVegan': newVegan})
    .then((value) => print("Vegan Status Updated"))
    .catchError((error) => print("Failed to update vegan status: $error"));
}

Future<void> updateUserStudent(bool newStudent) {
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userStudent': newStudent})
    .then((value) => print("Student Status Updated"))
    .catchError((error) => print("Failed to update student status: $error"));
}

Future<void> updateUserDOB(String newDOB) {
  List<String> splitted = newDOB.split(' ');//we split the time part and only use the date portion
  return collectionId
    .doc("JY77sv8HTXTkHay7RCt2")
    .update({'userDOB': splitted[0]})//index 0 is the date part, index 1 is the time part, we select index 0 to print
    .then((value) => print("Birth date Updated"))
    .catchError((error) => print("Failed to Birth date: $error"));
}


String yesnoanswer =""; //the variable for answering the vegan and student questions

String isUserVegan(bool thedata){ //getting the vegan status from the dataset
  if(thedata){
    yesnoanswer ="yes";//if true, return yes
    return yesnoanswer;
  }
  else{
    yesnoanswer= "no";//if false, return no
    return yesnoanswer;
  }
}

String isUserStudent(bool thedata){//getting the student status from the dataset
  if(thedata){
    yesnoanswer ="yes";//if true, return yes
    return yesnoanswer;
  }
  else{
    yesnoanswer= "no";//if false, return no
    return yesnoanswer;
  }
}

// https://flutterassets.com/split-string-in-flutter-examples/ --> splitting string