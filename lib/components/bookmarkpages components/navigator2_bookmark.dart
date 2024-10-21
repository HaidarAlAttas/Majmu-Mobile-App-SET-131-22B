import 'package:flutter/material.dart';

class Navigator2Bookmark extends StatelessWidget {
  final bool contentChoice;
  final int contentOrPost;
  final Function(bool, int) onUpdate;

  const Navigator2Bookmark({
    super.key,
    required this.contentChoice,
    required this.contentOrPost,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    // to create accurate sizing of the phone size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust container width to center it and reduce its size
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.1, // Set padding to center the container
        right: screenWidth * 0.1,
        bottom: screenHeight * 0.02,
      ),
      child: Container(
        height: screenHeight * 0.04, // Small height for the buttons
        width: screenWidth * 0.7, // Centered and smaller width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Spacing between buttons
          children: [
            // Content button
            GestureDetector(
              onTap: () {
                onUpdate(true, 0); // Update state on tap
              },
              child: Container(
                height: screenHeight * 0.03,
                width: screenWidth * 0.3, // Shrinked button width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: contentChoice ? Colors.black : Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Content",
                    style: TextStyle(
                      fontSize: 14, // Adjusted font size
                      color: contentChoice ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Post button
            GestureDetector(
              onTap: () {
                onUpdate(false, 1); // Update state on tap
              },
              child: Container(
                height: screenHeight * 0.03,
                width: screenWidth * 0.3, // Shrinked button width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: contentChoice ? Colors.white : Colors.black,
                ),
                child: Center(
                  child: Text(
                    "Post",
                    style: TextStyle(
                      fontSize: 14, // Adjusted font size
                      color: contentChoice ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
