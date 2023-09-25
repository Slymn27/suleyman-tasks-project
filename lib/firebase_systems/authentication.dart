import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'temp_firestore.dart'; //change this
import 'widgets.dart';

// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: loggedIn 
        ? Column(
      children: [
        UserData(),
        StyledButton(
            onPressed: () {
              signOut();
              FirebaseAuth.instance.signOut().then((value) => print("logged out"));
            },
            child: const Text('Logout')),
      ],
    )
    :Column(
      children: [
          const Text("You are Signed out",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        StyledButton(
          onPressed: () {
            context.push('/sign-in');
          },
          child: const Text('Login')),
      ],
    )
    );
  }
}
