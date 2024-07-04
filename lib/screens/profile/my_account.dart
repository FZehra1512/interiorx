import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/screens/profile/components/profile_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyAccount extends StatefulWidget {
  static String routeName = "/profile/my_account";
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late User _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _fetchUserData();
  }

  // Fetch User data
  Future<void> _fetchUserData() async {
    try {
      print('Fetching user data...');
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();
      print('User data fetched.');

      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>?;

        // Convert Timestamp to DateTime for Date of Birth
        if (_userData != null && _userData!.containsKey('DOB')) {
          Timestamp dobTimestamp = _userData!['DOB'];
          DateTime dobDateTime = dobTimestamp.toDate();
          _userData!['DOB'] =
              '${dobDateTime.year}-${dobDateTime.month}-${dobDateTime.day}';
        }
        // Handle nested address field
        if (_userData != null && _userData!.containsKey('address')) {
          Map<String, dynamic> addressMap = _userData!['address'];
          if (addressMap.containsKey('address_1')) {
            Map<String, dynamic> address1 = addressMap['address_1'];
            _userData!['address'] = address1['address'];
          }
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
      debugPrintStack();
    }
  }

  // Updata User Data
  Future<void> _updateUserData(Map<String, dynamic> newData) async {
    // Convert DOB back to Timestamp if it's a string (for updating)
    if (newData.containsKey('DOB') && newData['DOB'] is String) {
      try {
        DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(newData['DOB']);
        newData['DOB'] = Timestamp.fromDate(parsedDate);
      } catch (e) {
        print('Error parsing date: $e');
        return;
      }
    }

    // Handle nested address field for updating
    if (newData.containsKey('address')) {
      Map<String, dynamic> addressMap = {
        'address_1': {'address': newData['address']}
      };
      newData['address'] = addressMap;
    }

    try {
      print('Updating user data...');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .update(newData);
      print('User data updated.');
      _fetchUserData(); // Refresh the user data
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  void _showEditSectionDialog(String section, Map<String, dynamic> data) {
    final _formKey = GlobalKey<FormState>();
    Map<String, dynamic> updatedData = Map.from(data);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $section'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  if (section == 'Account Information') ...[
                    _buildTextFormField('Name',
                        updatedData['name']?.toString() ?? '', updatedData),
                    SizedBox(
                      height: 30,
                    ),
                    _buildTextFormField('Phone',
                        updatedData['phone']?.toString() ?? '', updatedData),
                  ] else if (section == 'Personal Information') ...[
                    _buildTextFormField(
                        'Address',
                        (updatedData['address'] != null &&
                                updatedData['address'] is Map &&
                                updatedData['address'].containsKey('address_1'))
                            ? updatedData['address']['address_1']['address']
                            : '',
                        updatedData),
                    SizedBox(
                      height: 30,
                    ),
                    _buildTextFormField(
                        'Gender',
                        updatedData['gender']?.toString() ?? '',
                        updatedData, validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (value.toLowerCase() != 'male' &&
                            value.toLowerCase() != 'female') {
                          return 'Please enter only "Male" or "Female"';
                        }
                      }
                      return null;
                    }),
                    SizedBox(
                      height: 30,
                    ),
                    _buildTextFormField('Date of Birth',
                        updatedData['DOB']?.toString() ?? '', updatedData,
                        hintText: '1995-04-05'),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateUserData(updatedData);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  TextFormField _buildTextFormField(
      String label, String initialValue, Map<String, dynamic> updatedData,
      {String? hintText, String? Function(String?)? validator}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      onChanged: (value) {
        // Handle special case for 'DOB'
        if (label == 'Date of Birth') {
          updatedData['DOB'] = value;
        } else {
          updatedData[label.toLowerCase().replaceAll(' ', '_')] = value;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Account',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.only(left: 20, right: 20),
              children: [
                Center(
                  child: ProfilePic(
                    backgroundColor: Color(0xff37185d),
                    size: 120,
                    iconColor: Colors.white,
                  ),
                ),
                Divider(height: 40, thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Account Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditSectionDialog('Account Information', {
                          'name': _userData!['name'],
                          'phone': _userData!['phone'],
                        });
                      },
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(_userData!['name'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(_user.email ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Phone Number'),
                  subtitle: Text(_userData!['phone'] ?? 'N/A'),
                ),
                Divider(height: 40, thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Personal Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditSectionDialog('Personal Information', {
                          'address': _userData!['address'],
                          'gender': _userData!['gender'],
                          'DOB': _userData!['DOB'],
                        });
                      },
                    ),
                  ],
                ),
                ListTile(
                  title: Text('Address'),
                  subtitle: Text(_userData!['address'] ?? 'N/A'),
                ),
                ListTile(
                  title: Text('Gender'),
                  subtitle: Text(
                    (_userData != null &&
                            _userData!.containsKey('address') &&
                            _userData!['address'] is Map &&
                            _userData!['address'].containsKey('address_1'))
                        ? _userData!['address']['address_1']['address']
                        : 'N/A',
                  ),
                ),
                ListTile(
                  title: Text('Date of Birth'),
                  subtitle: Text(_userData!['DOB'] ?? 'N/A'),
                ),
              ],
            ),
    );
  }
}
