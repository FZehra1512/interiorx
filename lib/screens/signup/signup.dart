import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interiorx/screens/home/home_screen.dart';
import 'package:interiorx/screens/login/login.dart';


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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'Create New Account',
            //   textAlign: TextAlign.center,
            //   style: GoogleFonts.poppins(
            //     textStyle: const TextStyle(
            //       fontWeight: FontWeight.w900,
            //       fontSize: 40,
            //     ),
            //   ),
            // ),
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
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () async {
                // try {
                //   await _auth.createUserWithEmailAndPassword(
                //     email: email,
                //     password: password,
                //   );

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

                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
    );
  }
}
