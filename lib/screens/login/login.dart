import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
                child: const Text('Login'),
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    cartProvider.clearCart();
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
                child: const Text("Don't have an account? Register here"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignupScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
