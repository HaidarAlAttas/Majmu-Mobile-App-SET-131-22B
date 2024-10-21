// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onTap;

  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        height: screenHeight * 0.15,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // section name
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sectionName,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: screenHeight * 0.02,
            ),
            // text
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
