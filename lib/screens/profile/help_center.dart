import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_app_bar.dart';

class HelpCenter extends StatelessWidget {
  static String routeName = "/support_center";

  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help Center',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            "Frequently Asked Questions",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ExpansionTile(
            title: Text("How do I create an account?"),
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "To create an account, click on the sign-up button on the home screen..."))
            ],
          ),
          ExpansionTile(
            title: Text("How do I place an order?"),
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "To place an order, browse through the products, add them to your cart, and proceed to checkout..."))
            ],
          ),
          ExpansionTile(
            title: Text("What are the payment options available?"),
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "We accept various payment methods including credit/debit cards, PayPal, and bank transfers..."))
            ],
          ),
          SizedBox(height: 24),
          Text(
            "Contact Us",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: Text("Email"),
            subtitle: Text("support@example.com"),
          ),
          ListTile(
            title: Text("Phone"),
            subtitle: Text("+123456789"),
          ),
          ListTile(
            title: Text("Address"),
            subtitle: Text("123 Main Street, City, Country"),
          ),
          SizedBox(height: 24),
          Text(
            "Submit a Support Request",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SupportForm(),
        ],
      ),
    );
  }
}

class SupportForm extends StatefulWidget {
  @override
  _SupportFormState createState() => _SupportFormState();
}

class _SupportFormState extends State<SupportForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      // For example, you can send the data to a backend server
      print("Name: ${_nameController.text}");
      print("Email: ${_emailController.text}");
      print("Message: ${_messageController.text}");

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Support request submitted successfully!")));

      // Clear the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(labelText: "Message"),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
