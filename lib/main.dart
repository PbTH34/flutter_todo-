import 'package:flutter/material.dart';
import 'package:flutter_todo/Servises/firebase_stream.dart';
import 'package:flutter_todo/pages/VerifyEmailScreen.dart';
import 'package:flutter_todo/pages/account_screen.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/login_screen.dart';
import 'package:flutter_todo/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo/pages/reset_password_screen.dart';
import 'package:flutter_todo/pages/signup_screen.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      primaryColor: Colors.cyan,
    ),
    routes: {
      '/':(context) => const FirebaseStream(),
      '/todo': (context) => const Home(),
      '/home': (context) => const MainScreen(),
      '/account': (context) => const AccountScreen(),
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      '/reset_password': (context) => const ResetPasswordScreen(),
      '/verify_email': (context) => const VerifyEmailScreen(),

    },
    initialRoute: '/',
  ));
}