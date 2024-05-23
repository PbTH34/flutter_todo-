import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/main_screen.dart';

import '../pages/VerifyEmailScreen.dart';



class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
          body: Center(child: Text('Что-то пошло не так!'),),
          );
    } else if (snapshot.hasData){
          if (!snapshot.data!.emailVerified){
            return const VerifyEmailScreen();
    }
          return const MainScreen();
    } else {
         return const MainScreen();
        }
      },
    );
  }
}
