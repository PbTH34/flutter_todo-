import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/Servises/snack_bar.dart';
import 'package:flutter_todo/pages/main_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
bool isEmailVerified = false;
bool canResendEmail = false;
Timer? timer;

@override
void initState(){
  super.initState();

  isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  if (!isEmailVerified){
    sendVerificationEmail();

    timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
    );
  }
}

@override
void dispose(){
  timer?.cancel();
  super.dispose();
}

Future<void> checkEmailVerified() async {
  await FirebaseAuth.instance.currentUser!.reload();

  setState(() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  });

  print(isEmailVerified);

  if (isEmailVerified) timer?.cancel();
}

Future<void> sendVerificationEmail() async{
  try{
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();

    setState(() => canResendEmail =false);
    await Future.delayed(const Duration(seconds: 5,));

    setState(() => canResendEmail = true);
  } catch (e){
    print(e);
    if (mounted) {
      SnackBarService.showSnackBar(
          context,
          '$e',
          true);
    }
  }
}

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MainScreen()
      : Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: const Text('Верификация Email адреса'),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Письмо с подтверждение было отправлено на вашу почту',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton.icon(
                onPressed: canResendEmail ? sendVerificationEmail : null,
              icon: const Icon(Icons.email),
              label: const Text('Повторно отправить'),
            ),
            const SizedBox(height: 30,),
            TextButton(
                onPressed: () async{
                  timer?.cancel();
                  await FirebaseAuth.instance.currentUser!.delete();
                },
                child: const Text(
                  'Отменить',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
            ),
          ],
        ),
      ),
    ),
  );
}
