// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ContentButton extends StatefulWidget {
  final VoidCallback onTap;
  final String name;

  const ContentButton({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  State<ContentButton> createState() => _ContentButtonState();
}

class _ContentButtonState extends State<ContentButton> {
  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      // Detect input
      onTap: () {
        setState(() {
          widget.onTap();
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Surah content name
            Expanded(
              child: Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
            // Icon to go to the content file (>)
            Icon(
              Icons.navigate_next_rounded,
              color: Colors.black,
              size: screenWidth * 0.089,
            ),
          ],
        ),
      ),
    );
  }
}
