import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Navigator2Bookmark extends StatelessWidget {
  final bool contentChoice;
  final int contentOrPost;
  final Function(bool, int)
      onUpdate; // Add a callback for updating the parent state

  const Navigator2Bookmark({
    super.key,
    required this.contentChoice,
    required this.contentOrPost,
    required this.onUpdate, // Initialize the callback
  });

  @override
  Widget build(BuildContext context) {
    // to create accurate sizing of the phone size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Container for public and private bookmark navigator
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.03,
        right: screenWidth * 0.03,
        bottom: screenHeight * 0.02,
      ),
      child: Container(
        height: screenHeight * 0.047,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Public button
            GestureDetector(
              onTap: () {
                onUpdate(
                    true, 0); // Use the callback to update the parent state
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.02, right: screenWidth * 0.01),
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contentChoice
                        ? Colors.black
                        : Colors.white, // Change color based on selection
                  ),
                  child: Center(
                    child: Text(
                      "Content",
                      style: TextStyle(
                        color: contentChoice
                            ? Colors.white
                            : Colors
                                .black, // Change text color based on selection
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Private button
            GestureDetector(
              onTap: () {
                onUpdate(
                    false, 1); // Use the callback to update the parent state
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.02, right: screenWidth * 0.01),
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: contentChoice
                        ? Colors.white
                        : Colors.black, // Change color based on selection
                  ),
                  child: Center(
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: contentChoice
                            ? Colors.black
                            : Colors
                                .white, // Change text color based on selection
                        fontWeight: FontWeight.bold,
                      ),
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
