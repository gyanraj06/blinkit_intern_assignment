import 'package:blinkit_webapp_assignment/pages/home_page.dart';
import 'package:blinkit_webapp_assignment/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user log in
          if (snapshot.hasData) {
            return HomePage();
          }
          //not log in
          else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
