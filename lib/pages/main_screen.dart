import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'login_screen.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
          title: Text('Главная страница', style: TextStyle(color: Colors.white, fontSize: 25),),
          backgroundColor: Colors.blue[200],
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (){
                  if ((user == null)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountScreen()),
                    );
                  }
                },
                icon: Icon(
                  Icons.person,
                  color: (user == null)? Colors.white : Colors.yellow,
                )
            ),
          ],
        ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (user == null)
               ?Text('Main Screen not Auth') : Text('Main Screen Auth'),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacementNamed(context, '/todo');
              },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  child: Text('Перейти к делам', ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
