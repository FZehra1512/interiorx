import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/login/login.dart';
import 'package:interiorx/screens/userInfo/userInfo.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';


class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  String email = '';
  String password = '';
  String errorMessage = '';


  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Create a new document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
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
  }

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

  // Function to validate email
  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/interiorx-logo.svg',
                  height: 110,
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
                const SizedBox(height: 30),
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
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18),
                  ),
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
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        // Create a new document in Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userCredential.user!.uid)
                            .set({
                          'email': email,
                          // Add any other user data you want to store
                          'createdAt': FieldValue.serverTimestamp(),
                        });
                        cartProvider.clearCart();
                        Navigator.pushReplacementNamed(
                            context, UserInfoScreen.routeName);
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
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: const Text('Login here',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                // const Text(
                //   "Or Sign Up with",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: kTextColor,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500),
                // ),
                // TextButton(
                //   onPressed: _signInWithGoogle, 
                //   child: SizedBox(
                //     height: 50,
                //     width: 50,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(25),
                //       child: Image.asset(
                //         'assets/images/googleicon.png',
                //         width: 10,
                //         height: 10,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
