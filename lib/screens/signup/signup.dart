import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interiorx/screens/login/login.dart';
import 'package:interiorx/screens/userInfo/userInfo.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String errorMessage = '';

  // Function to handle error messages
  String getFriendlyErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An unknown error occurred.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              SvgPicture.asset(
                'assets/interiorx-logo.svg',
                height: 130,
              ),
              const Text(
                'InteriorX',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Create New Account',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () async {
                  try {
                    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Create a new document in Firestore
                    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                      'email': email,
                      // Add any other user data you want to store
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    Navigator.pushReplacementNamed(context, UserInfoScreen.routeName);
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      errorMessage = getFriendlyErrorMessage(e.code);
                    });
                  } catch (e) {
                    setState(() {
                      errorMessage = 'An unknown error occurred.';
                    });
                  }
                },
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              TextButton(
                child: const Text("Already have an account? Login here"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
