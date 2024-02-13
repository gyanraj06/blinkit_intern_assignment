import 'package:blinkit_webapp_assignment/pages/signup_page.dart';
import 'package:blinkit_webapp_assignment/widget/custom_button.dart';
import 'package:blinkit_webapp_assignment/widget/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    //Show Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPassMessage();
      }
    }

    Navigator.pop(context);
  }

  wrongPassMessage() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Incorrect Passeord'),
      ),
    );
  }

  wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Incorrect Email'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          //* Logo and Title Container
          Container(
            width: width / 2.5,
            color: const Color(0xFFF8CB46),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/blink_it.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Internship Assignment Web App Auth Page",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //* Sign In Container
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Hello There! ",
                      style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff0C831F)),
                      children: [
                        TextSpan(
                          text: "Sign In to Continue!",
                          style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomField(
                      label: "Enter Email", controller: usernameController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomField(
                      label: "Enter Password", controller: passwordController),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      signUserIn();
                    },
                    child: const CustomButton(
                      label: "Sign In",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //* New User, Sign Up here
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New User?",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sign Up",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0C831F),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
