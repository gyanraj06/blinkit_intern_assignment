import 'package:blinkit_webapp_assignment/pages/signin_page.dart';
import 'package:blinkit_webapp_assignment/widget/custom_button.dart';
import 'package:blinkit_webapp_assignment/widget/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void signUserUp() async {
    //Show Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    //try sign in
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: usernameController.text, password: passwordController.text);
      } else {
        print("Password don't match");
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
      Navigator.pop(context);
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
                      text: "Welcome! ",
                      style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff0C831F)),
                      children: [
                        TextSpan(
                          text: "Sign Up as New User!",
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
                    height: 10,
                  ),
                  CustomField(
                      label: "Confirm Password",
                      controller: confirmpasswordController),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => signUserUp(),
                    child: const CustomButton(
                      label: "Sign Up",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //* New User, Sign Up here
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Existing User?",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sign In",
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
