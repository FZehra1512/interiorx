import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/checkout/components/section_header.dart';
import 'package:interiorx/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const addresses = [
  {
    "name": "Fatima Zehra",
    "phone": "+92 3243320060", 
    "address": "DT-13, Block 12, Gulberg, F.B Area, Karachi"
  },
  {
    "name": "Fatima Zehra",
    "phone": "+92 3243320060",
    "address": "DT-13, Block 12, Gulberg, F.B Area, Karachi"
  },
  {
    "name": "Fatima Zehra",
    "phone": "+92 3243320060",
    "address": "DT-13, Block 12, Gulberg, F.B Area, Karachi"
  },
];

class ShippingAddressSection extends StatelessWidget {
  const ShippingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    const name = "Fatima Zehra";
    const phone = "+92 3243320060";
    const address = "DT-13, Block 12, Gulberg, F.B Area, Karachi";
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Shipping Address',
            onTap: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: const AddressModal(),
                ) 
              );
            },
          ),
          const SizedBox(height: 8),
          const AddressText(icon: Icons.person, title: name),
          const AddressText(icon: Icons.phone, title: phone),
          const AddressText(icon: Icons.location_on, title: address),
        ],
      ),
    );
  }
}




class AddressModal extends StatelessWidget {
  const AddressModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: buildBackIconButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final address = addresses[index];
            return CustomCard(
              child: Column(
                children: [
                  AddressText(icon: Icons.person, title: address.values.elementAt(0)),
                  AddressText(icon: Icons.phone, title: address.values.elementAt(1)),
                  AddressText(icon: Icons.location_on, title: address.values.elementAt(2)),
                ],
              )
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 4.0,);
          },
        ),
      )
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
      child: InkWell(
        onTap: (){print("Address selected");},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon, color: kTextColor,
              size: 22,
            ),
            const SizedBox(width: 20,),
            Expanded(child: Text(title, style: const TextStyle(color: kTextColor, fontSize: 15), softWrap: true, overflow: TextOverflow.visible,))
          ],
        ),
      ),
    );
  }
}
