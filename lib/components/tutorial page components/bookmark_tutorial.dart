import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarkTutorial extends StatelessWidget {
  const BookmarkTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    // Variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF69B964), // Lighter green
            Color(0xFF4A8B47), // Darker green
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image with rounded corners and shadow
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/bookmark page tuto gif.gif",
                height: screenHeight * 0.55,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Title Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Text(
              "Introducing Bookmark page!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: screenWidth * 0.05,
                letterSpacing: 1.2,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          // Description Text with softer colors
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              "Save documents and posts that you want all in one place",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
                fontSize: screenWidth * 0.045,
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.03),
        ],
      ),
    );
  }
}
