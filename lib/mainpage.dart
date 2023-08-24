import 'package:flutter/material.dart';
import 'package:suleymankiskacproject/firestore.dart';
import 'package:suleymankiskacproject/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            padding: EdgeInsets.only(left: 8, right: 15.0),
            child: IconButton(
              iconSize: 42,
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ProfilePage(title: 'profile Page',)),
                );
              },
              icon: const Icon(Icons.person_rounded),
              color: Color.fromARGB(255, 48, 128, 51),
            ),
          )
        ], //https://api.flutter.dev/flutter/material/AppBar-class.html AppBar class
      ),
      body: UserData(),

      
      bottomNavigationBar: BottomNavigationBar(//https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html bottom navigation bar
        backgroundColor: Color.fromARGB(255, 128, 218, 131),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sell_outlined,
              size: 32, color: Color.fromARGB(255, 48, 128, 51),
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
