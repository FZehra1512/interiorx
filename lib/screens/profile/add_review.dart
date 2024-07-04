import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/constants.dart';

class SelectProductForReviewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final String userId;

  const SelectProductForReviewScreen({
    Key? key,
    required this.products,
    required this.userId,
  }) : super(key: key);

  @override
  _SelectProductForReviewScreenState createState() =>
      _SelectProductForReviewScreenState();
}

class _SelectProductForReviewScreenState
    extends State<SelectProductForReviewScreen> {
  String? selectedProductId;
  String? selectedProductName;
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _rating = 5;

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('reviews').add({
          'productId': selectedProductId,
          'userId': widget.userId,
          'rating': _rating,
          'review': _reviewController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        setState(() {
          selectedProductId = null;
          selectedProductName = null;
          _reviewController.clear();
          _rating = 5;
        });
      } catch (e) {
        print('Error adding review: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Product for Review',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.products.map((product) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: SvgPicture.asset(
                            'assets/interiorx-logo.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(product['name']),
                        trailing: Text(
                            'Rs ${(product['price'] * product['quantity']).toStringAsFixed(2)}'),
                        contentPadding: EdgeInsets.all(10),
                        tileColor: kSecondaryColor,
                        onTap: () {
                          setState(() {
                            selectedProductId = product['productId'];
                            selectedProductName = product['name'];
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (selectedProductId != null) ...[
              //SizedBox(height: 20),
              Text(
                'Add Review for $selectedProductName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _reviewController,
                      decoration: InputDecoration(labelText: 'Review'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a review';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: _rating,
                      decoration: InputDecoration(labelText: 'Rating'),
                      items: List.generate(5, (index) => index + 1)
                          .map((rating) => DropdownMenuItem<int>(
                                value: rating,
                                child: Text(rating.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _rating = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitReview,
                      child: Text('Submit Review'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
