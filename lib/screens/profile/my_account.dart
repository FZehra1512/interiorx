import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/screens/profile/components/profile_pic.dart';

class MyAccount extends StatefulWidget {
  static String routeName = "/profile/my_account";
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Account',
        onBackPressed: () {
          // Add any custom logic here if needed
          Navigator.of(context).pop();
        },
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          Center(
            child: ProfilePic(),
          ),
          Divider(height: 40, thickness: 2),
          Text(
            "Account Information",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(
              'Name',
            ),
            subtitle: Text(
              'Ayesha Imam',
            ),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Handle name edit
            },
          ),
          ListTile(
            title: Text('Email'),
            subtitle: Text('user@example.com'),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Handle email edit
            },
          ),
          ListTile(
            title: Text('Phone Number'),
            subtitle: Text('+1234567890'),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Handle phone number edit
            },
          ),
          Divider(height: 40, thickness: 2),
          Text("Personal Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          ListTile(
            title: Text('Address'),
            subtitle: Text('123 Main St, City, Country'),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Handle address edit
            },
          ),
          ListTile(
            title: Text('Gender'),
            subtitle: Text('Male'),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Handle gender edit
            },
          ),
          ListTile(
            title: Text('Date of Birth'),
            subtitle: Text('01/01/1990'),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Handle date of birth edit
            },
          ),
        ],
      ),
    );
  }
}
