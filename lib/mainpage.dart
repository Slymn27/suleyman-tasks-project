import 'package:flutter/material.dart';
import 'package:suleymankiskacproject/firebase_systems/firestore.dart';
import 'package:suleymankiskacproject/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  int bottomNavIndex = 2;
  final screens = [
    const Center(child: Column(
       children: [
         Text("Sales", style:  TextStyle(fontSize: 36),),
         Text("Comming soon...", style:  TextStyle(fontSize: 24),)
       ],
     )),
    const Center(child: Column(
       children: [
         Text("Orders", style:  TextStyle(fontSize: 36),),
         Text("Comming soon...", style:  TextStyle(fontSize: 24),)
       ],
     )),
    UserData(),
    const Center(child: Column(
       children: [
         Text("Contacts", style:  TextStyle(fontSize: 36),),
         Text("Comming soon...", style:  TextStyle(fontSize: 24),)
       ],
     )),
    const Center(child: Column(
       children: [
         Text("Stock", style:  TextStyle(fontSize: 36),),
         Text("Comming soon...", style:  TextStyle(fontSize: 24),)
       ],
     )),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 218, 131),
        title: Text("CepDükkan",style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 44),),
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
      body:screens[bottomNavIndex], // calling the method from a differen file. Writing the user data that we got from firestore

      bottomNavigationBar: BottomNavigationBar(
        //https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html bottom navigation bar
        currentIndex: bottomNavIndex,
        onTap: (index) => setState (() => bottomNavIndex = index),
        selectedItemColor: Color.fromARGB(255, 19, 71, 21),
        backgroundColor: Color.fromARGB(255, 128, 218, 131),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //creating a bottom navigation bar with 5 items
            icon: Icon(
              Icons.sell_outlined,
              size: 32,
              color: Color.fromARGB(255, 48, 128, 51),
            ),
            label: "Sales",
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
              label: "Contacts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory_outlined,
                  size: 32, color: Color.fromARGB(255, 48, 128, 51)),
              label: "Stock"),
        ],
        
      ),
    );
  }
}
