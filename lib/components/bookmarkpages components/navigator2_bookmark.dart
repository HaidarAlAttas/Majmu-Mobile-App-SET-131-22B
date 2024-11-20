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
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
        vertical: screenHeight * 0.02,
      ),
      // main container
      child: Container(
        height: screenHeight * 0.04, // Slightly increased height for balance
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // stack for animation
        child: Stack(
          children: [
            // Animated selection indicator
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: contentChoice ? 0 : screenWidth * 0.5 - screenWidth * 0.11,
              top: 0,
              bottom: 0,
              child: Container(
                width: screenWidth * 0.40,  // Adjusted width for better proportion
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.green,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            // Row with buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Content button
                GestureDetector(
                  onTap: () {
                    onUpdate(true, 0);
                  },
                  child: Container(
                    width: screenWidth * 0.30, // Consistent width for both buttons
                    alignment: Alignment.center,
                    child: Text(
                      "Content",
                      style: TextStyle(
                        color: contentChoice ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.042,
                      ),
                    ),
                  ),
                ),
                // Post button
                GestureDetector(
                  onTap: () {
                    onUpdate(false, 1);
                  },
                  child: Container(
                    width: screenWidth * 0.30, // Consistent width for both buttons
                    alignment: Alignment.center,
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: !contentChoice ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.042,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
