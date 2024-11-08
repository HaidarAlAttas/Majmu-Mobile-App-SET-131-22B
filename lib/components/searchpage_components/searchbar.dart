import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onChanged;

  const MySearchBar({
    super.key,
    required this.searchController,
    required this.onChanged, // Receive onSubmitted function
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: TextField(
        controller: widget.searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          labelText: "Search in Homepage",
          labelStyle: TextStyle(color: Colors.black),
          hintText: "Type to search...",
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.black),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear, color: Colors.grey[600]),
            onPressed: () {
              widget.searchController.clear();
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        cursorColor: Colors.green,
        onChanged: (value) {
          setState(() {
            widget.onChanged(value);
          });
        }, // Trigger the search in SearchPage
      ),
    );
  }
}
