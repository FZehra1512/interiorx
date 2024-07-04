import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interiorx/screens/home/home_screen.dart';
import 'package:interiorx/constants.dart';

class UserInfoScreen extends StatefulWidget {
  static String routeName = "/user_info";
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String name = '';
  String address = '';
  String phone = '';
  String? _selectedCity;
  List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Peshawar',
    'Quetta',
    'Hyderabad',
    'Rawalpindi',
    'Faisalabad'
  ];
  String errorMessage = '';

  bool isValidName(String name) => name.isNotEmpty;
  bool isValidPhone(String phone) => phone.isNotEmpty;
  bool isValidAddress(String address) => address.isNotEmpty;
  bool isValidCity(String? city) => city != null;

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String address,
    required String? city,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Create the address map with the required structure
        Map<String, dynamic> addressMap = {
          "address_1": {
            "name": name,
            "number": phone,
            "address": "$address, $city"
          }
        };

        // Update the user document in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'name': name,
          'phone': phone,
          'address': addressMap,
        });
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An unknown error occurred.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_circle,
                    size: 100, color: kPrimaryLightColor),
                const Text(
                  'Profile Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(labelText: 'Address'),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  items: cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(
                        city,
                        style: const TextStyle(color: kTextColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (!isValidName(name)) {
                      setState(() {
                        errorMessage = 'Please enter your name';
                      });
                    } else if (!isValidPhone(phone)) {
                      setState(() {
                        errorMessage = 'Please enter your phone number';
                      });
                    } else if (!isValidAddress(address)) {
                      setState(() {
                        errorMessage = 'Please enter your address';
                      });
                    } else if (!isValidCity(_selectedCity)) {
                      setState(() {
                        errorMessage = 'Please select your city';
                      });
                    } else {
                      await updateUserProfile(
                          name: name,
                          phone: phone,
                          address: address,
                          city: _selectedCity);
                    }
                  },
                  child: const Text('Submit'),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
