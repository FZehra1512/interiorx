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
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  // String gender = 'Male';
  String phone = '';
  String city = 'Karachi';
  // DateTime? dob;

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required String address,
    required String city,
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
          'gender': 'N/A',
          'DOB': 'N/A',
          'address': addressMap,
        });
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    } catch (e) {
      // Handle any errors here
      print('Error updating user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Info')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_circle, size: 150, color: kPrimaryLightColor),
                const Text(
                  'Profile Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone'),
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField(
                  value: city,
                  decoration: const InputDecoration(labelText: 'City'),
                  items: ['Karachi', 'Lahore', 'Islamabad', 'Peshawar', 'Quetta', 'Hyderabad', 'Rawalpindi', 'Faisalabad']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      city = value!;
                    });
                  },
                ),
                // DropdownButtonFormField(
                //   value: gender,
                //   decoration: const InputDecoration(labelText: 'Gender'),
                //   items: ['Male', 'Female']
                //       .map((label) => DropdownMenuItem(
                //             child: Text(label),
                //             value: label,
                //           ))
                //       .toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       gender = value!;
                //     });
                //   },
                // ),
                
                
                // TextFormField(
                //   decoration: const InputDecoration(labelText: 'Date of Birth'),
                //   onTap: () async {
                //     FocusScope.of(context).requestFocus(FocusNode());
                //     DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(1900),
                //       lastDate: DateTime(2101),
                //     );
                //     if (pickedDate != null) {
                //       setState(() {
                //         dob = pickedDate;
                //       });
                //     }
                //   },
                //   validator: (value) {
                //     if (dob == null) {
                //       return 'Please select your date of birth';
                //     }
                //     return null;
                //   },
                //   readOnly: true,
                //   controller: TextEditingController(
                //     text: dob == null ? '' : '${dob!.toLocal()}'.split(' ')[0],
                //   ),
                // ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    updateUserProfile(name: name, phone: phone, address: address, city: city);
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
