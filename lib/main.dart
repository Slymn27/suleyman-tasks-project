//süleyman Emre Kıskaç - Task 7 - Task 9 - Task 10
//used resources are mentioned at the bottom of the code
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new added
import 'package:go_router/go_router.dart';               // new added
import 'package:provider/provider.dart';                 // new added

import 'firebase_systems/firebase_options.dart';
import 'firebase_systems/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // we initialize a new instance to be able to use firebase apps
    options: DefaultFirebaseOptions.currentPlatform, // we set the options to default options
  );
    runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(title: "main page",),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null
                  };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  // using stateless widget for the base of the app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 48, 128, 51)),
        useMaterial3: true,
      ),
      routerConfig: _router,
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
