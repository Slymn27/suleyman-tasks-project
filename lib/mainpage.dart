import 'package:firebase_auth/firebase_auth.dart' // new added
    hide EmailAuthProvider, PhoneAuthProvider;    // new added
import 'package:flutter/material.dart';           
import 'package:provider/provider.dart';          // new added
import 'package:suleymankiskacproject/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_systems/firestore.dart';
import 'firebase_systems/app_state.dart';
import 'firebase_systems/widgets.dart';
import 'firebase_systems/authentication.dart';


class MainPage extends StatefulWidget {
  //turned the mainpage into a stateful widget because the main screen will show the user data
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

FirebaseFirestore firestore =
    FirebaseFirestore.instance; //accesing the instance

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 218, 131),
        leading: const Placeholder(),
        title: const Placeholder(fallbackHeight: 40.0),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 15.0),
            child: IconButton(
              iconSize: 42,
              onPressed: () {
                Navigator.push(
                  //navigating to profile page by clicking the person icon
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePage(
                            title: 'profile Page',
                          )),
                );
              },
              icon: const Icon(Icons.person_rounded),
              color: Color.fromARGB(255, 48, 128, 51),
            ),
          )
        ], //https://api.flutter.dev/flutter/material/AppBar-class.html AppBar class
      ),
      body:         
      Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          child:UserData(), // calling the method. Writing the user data that we got from database
          ),
      bottomNavigationBar: BottomNavigationBar(
        //https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html bottom navigation bar
        backgroundColor: Color.fromARGB(255, 128, 218, 131),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //creating a bottom navigation bar with 5 items
            icon: Icon(
              Icons.sell_outlined,
              size: 32,
              color: Color.fromARGB(255, 48, 128, 51),
            ),
            label: "Sale",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined,
                  size: 32, color: Color.fromARGB(255, 48, 128, 51)),
              label: "Orders"),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 32, color: Color.fromARGB(255, 48, 128, 51)),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded,
                  size: 32, color: Color.fromARGB(255, 48, 128, 51)),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory_outlined,
                  size: 32, color: Color.fromARGB(255, 48, 128, 51)),
              label: "Vendors"),
        ],
        selectedItemColor: Color.fromARGB(255, 19, 71, 21),
        currentIndex: 2,
      ),
    );
  }
}
