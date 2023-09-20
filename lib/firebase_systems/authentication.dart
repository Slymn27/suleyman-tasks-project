import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'firestore.dart';
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
      child: Column(
      children: [
        loggedIn ? UserData() : const Text("You are Signed out", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: StyledButton(
              onPressed: () { 
                !loggedIn ? context.push('/sign-in') : signOut();
              },
              child: !loggedIn ? const Text('Login') : const Text('Logout')),
        ),
      ],
    ));
  }
}
