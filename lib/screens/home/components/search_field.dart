import 'package:flutter/material.dart';
import '../../../constants.dart';

class SearchField extends StatefulWidget {final void Function(String query) onSearch;
  const SearchField({Key? key, required this.onSearch,}) : super(key: key);
  _SearchFieldState createState() => _SearchFieldState();}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  Widget build(BuildContext context) {
    return Form(child: TextFormField(controller: _controller,
        decoration: InputDecoration(filled: true,
          fillColor: kSecondaryColor.withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: searchOutlineInputBorder, hintText: "Search product",
          focusedBorder: searchOutlineInputBorder,
          enabledBorder: searchOutlineInputBorder,
          suffixIcon: IconButton(icon: const Icon(Icons.search, color: kTextColor,),
            onPressed: () {widget.onSearch(_controller.text);},),
        ),),);}}

const searchOutlineInputBorder = OutlineInputBorder(borderSide: BorderSide.none,
  borderRadius: BorderRadius.all(Radius.circular(12)),);
