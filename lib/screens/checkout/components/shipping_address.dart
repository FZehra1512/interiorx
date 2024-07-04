import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/checkout/components/section_header.dart';
import 'package:interiorx/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddressService {
  static Future<Map<String, dynamic>?> fetchUserAddress() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot currentUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (currentUser.exists) {
          Map<String, dynamic>? userData = currentUser.data() as Map<String, dynamic>?;
          if (userData != null && userData.containsKey('address')) {
            List<Map<String, dynamic>> addresses =
                (userData['address'] as Map<String, dynamic>)
                    .values
                    .map((e) => e as Map<String, dynamic>)
                    .toList();
            Map<String, dynamic>? userAddress =
                userData['address']?['address_1'];
            return {'userAddress': userAddress, 'addresses': addresses};
          }
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
    return null;
  }
}

class ShippingAddressSection extends StatefulWidget {
  final GlobalKey<ShippingAddressSectionState> key;
  const ShippingAddressSection({required this.key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  ShippingAddressSectionState createState() => ShippingAddressSectionState();
}

class ShippingAddressSectionState extends State<ShippingAddressSection> {
  Map<String, dynamic>? userAddress;

  @override
  void initState() {
    super.initState();
    _loadUserAddress();
  }

  Future<void> _loadUserAddress() async {
    Map<String, dynamic>? userData = await AddressService.fetchUserAddress();
    if (userData != null) {
      setState(() {
        userAddress = userData['userAddress'];
      });
    }
  }

  void _updateAddress(Map<String, dynamic> newAddress) {
    setState(() {
      userAddress = newAddress;
    });
  }

  Map<String, dynamic>? getAddress() {return userAddress;}

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Shipping Address',
            onTap: () async {
              final selectedAddress =
                  await showMaterialModalBottomSheet<Map<String, dynamic>>(
                context: context,
                builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: AddressModal(onUpdateAddress: _updateAddress),
                ),
              );
              if (selectedAddress != null) {
                setState(() {
                  userAddress = selectedAddress;
                });
              }
            },
          ),
          const SizedBox(height: 8),
          userAddress != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddressText(
                        icon: Icons.person, title: '${userAddress?['name']}'),
                    AddressText(
                        icon: Icons.phone, title: "${userAddress?['number']}"),
                    AddressText(
                        icon: Icons.location_on,
                        title: '${userAddress?['address']}'),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}


class AddressModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onUpdateAddress;
  const AddressModal({super.key, required this.onUpdateAddress});

  @override
  // ignore: library_private_types_in_public_api
  _AddressModal createState() => _AddressModal();
}

class _AddressModal extends State<AddressModal> {
  List<Map<String, dynamic>> addresses = [];
  

  @override
    void initState() {
      super.initState();
      _loadUserAddress();
    }

    Future<void> _loadUserAddress() async {
      Map<String, dynamic>? userData = await AddressService.fetchUserAddress();
      if (userData != null) {
        setState(() {
          addresses = userData['addresses'];
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'Select Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    highlightColor: kPrimaryLightColor,
                    onTap: () {
                      Navigator.pop(context, address);
                    },
                    child: CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddressText(
                              icon: Icons.person, title: address['name']),
                          AddressText(
                              icon: Icons.phone, title: address['number']),
                          AddressText(
                              icon: Icons.location_on,
                              title: address['address']),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 4.0);
                },
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: NewAddressFormModal(onSave: widget.onUpdateAddress),
                      ),
                    );
                  },
                  child: const Text('Add New', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewAddressFormModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  const NewAddressFormModal({super.key, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _NewAddressFormModalState createState() => _NewAddressFormModalState();
}

class _NewAddressFormModalState extends State<NewAddressFormModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
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

  void _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          int addressMapLength = 1;
          Map<String, dynamic>? addressMap = {};

          if (userDoc.exists) {
            Map<String, dynamic>? userData =
                userDoc.data() as Map<String, dynamic>?;
            if (userData != null && userData.containsKey('address')) {
              addressMap = Map<String, dynamic>.from(userData['address']);
              addressMapLength = addressMap.length + 1;
            }
          }

          String name = _nameController.text;
          String phone = _phoneController.text;
          String address = _addressController.text;
          Map<String, dynamic> newAddress = {
            "name": name,
            "number": phone,
            "address": "$address, $_selectedCity"
          };
          addressMap['address_$addressMapLength'] = newAddress;

          // Update the user document in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'address': addressMap,
          });

          setState(() {
            // Update the state to show the newly added address
          });

          widget.onSave(newAddress);
          // ignore: use_build_context_synchronously
          Navigator.pop(context); // Close the modal
          // ignore: use_build_context_synchronously
          Navigator.pop(context); // Close the parent modal
        } catch (e) {
          print('Error saving address: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: buildBackIconButton(context),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
              items: cities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city, style: const TextStyle(color: kTextColor),),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your city';
                }
                return null;
              },
            ),
            const SizedBox(height: 38),
            ElevatedButton(
              onPressed: _saveAddress,
              child: const Text('Add Address'),
            ),
          ],
        ),
      ),
    );
  }
}



class AddressText extends StatelessWidget {
  final IconData icon;
  final String title;

  const AddressText({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: kTextColor,
            size: 22,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            title,
            style: const TextStyle(color: kTextColor, fontSize: 15),
            softWrap: true,
            overflow: TextOverflow.visible,
          ))
        ],
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        children: [
          buildBackIconButton(context),
          const SizedBox(width: 30,),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}



