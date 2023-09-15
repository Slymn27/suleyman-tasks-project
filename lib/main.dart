//süleyman Emre Kıskaç - Task 7 - Task 9 - Task 10
//used resources are mentioned at the bottom of the code
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:suleymankiskacproject/firebase_systems/firebase_options.dart';
import 'mainpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // we initialize a new instance to be able to use firebase apps
    options: DefaultFirebaseOptions
        .currentPlatform, // we set the options to default options
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // using stateless widget for the base of the app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 48, 128, 51)),
        useMaterial3: true,
      ),
      home: const MainPage(
        title: "Süleyman's Project",
      ), //calling Main page
    );
  }
}

/*REFERENCES AND USED RESOURCES:
[1] https://app.flutterflow.io/ --> overlay design
[2] https://stackoverflow.com/questions/52727535/what-is-the-correct-way-to-add-date-picker-in-flutter-app -->
--> date picker
[3] https://www.youtube.com/watch?v=IePaAGXzmtU --> image picker for profile picture
[4] https://www.youtube.com/watch?v=neAn35cY8y0 --> Scrollable page
[5] https://www.youtube.com/watch?v=DbkIQSvwnZc --> Scrollbar
[6] https://img.freepik.com/free-icon/user_318-644324.jpg --> non-profile picture image
[7] https://api.flutter.dev/flutter/material/TextField-class.html --> TextFields
[8] https://api.flutter.dev/flutter/material/Switch-class.html --> switches
[9] https://api.flutter.dev/flutter/material/Divider-class.html --> divider
*/
