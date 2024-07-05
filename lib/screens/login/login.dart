import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/home/home_screen.dart';
import 'package:interiorx/screens/signup/signup.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';


class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String errorMessage = '';

  // Function to handle error messages
  String getFriendlyErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'invalid-credential':
        return 'Please enter valid credentials';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'An unknown error occurred.';
    }
  }

  // Function to validate email
  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/images/InteriorX.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'InteriorX',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
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
                child: const Text('Login', style: TextStyle(fontSize: 18),),
                onPressed: () async {
                  if (email.isEmpty || password.isEmpty) {
                    setState(() {
                      errorMessage = 'Please fill in all fields';
                    });
                  } else if (!isValidEmail(email)) {
                    setState(() {
                      errorMessage = 'Invalid email address';
                    });
                  } else if (password.length < 6) {
                    setState(() {
                      errorMessage =
                          'Password should be at least 6 characters long';
                    });
                  } else {
                    try {
                      await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      cartProvider.clearCart();
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        errorMessage = getFriendlyErrorMessage(e.code);
                      });
                    } catch (e) {
                      setState(() {
                        errorMessage = 'An unknown error occurred.';
                      });
                    }
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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: kTextColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  GestureDetector(
                    onTap: () {Navigator.pushReplacementNamed(context, SignupScreen.routeName);},
                    child: const Text('Register here',
                        style: TextStyle(color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
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
