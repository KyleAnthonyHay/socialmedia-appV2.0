import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmediaapv2/components/MyButton.dart';
import 'package:socialmediaapv2/components/MyTextField.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../helper/HelperFunctions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords map
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error message to user
      displayMessageToUser("Passwords dont match!", context);
    } else {
      //if passwords match, then:
      // try creating the user
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        createUserDocument(userCredential);
        // pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        // pop loading circle
        Navigator.pop(context);

        // display error to user
        displayMessageToUser(error.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),
              //app name
              const Text(
                "M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              // User Name text field
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: userNameController,
              ),
              const SizedBox(height: 10),
              // Email text field
              MyTextField(
                hintText: "Emal",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              // password text field
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              // confirm password field
              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 25),
              // register button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),
              const SizedBox(height: 10),
              // blurb
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
