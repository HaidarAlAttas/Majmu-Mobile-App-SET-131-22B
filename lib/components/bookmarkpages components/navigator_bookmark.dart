import 'package:flutter/material.dart';

class NavigatorBookmark extends StatelessWidget {
  final bool publicChoice;
  final int puborpriv;
  final Function(bool, int)? onUpdate;

  const NavigatorBookmark({
    super.key,
    required this.onUpdate,
    required this.publicChoice,
    required this.puborpriv,
  });

  @override
  Widget build(BuildContext context) {
    // Screen size calculations for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.02,
      ),

      // main container
      child: Container(
        height: screenHeight * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
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
              left: publicChoice ? 0 : screenWidth * 0.5 - screenWidth * 0.04,
              top: 0,
              bottom: 0,
              child: Container(
                width:
                    screenWidth * 0.47, // Adjusted width for better proportion
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
                // Public button
                GestureDetector(
                  onTap: () {
                    onUpdate?.call(true, 0);
                  },
                  child: Container(
                    width: screenWidth * 0.43,
                    alignment: Alignment.center,
                    child: Text(
                      "Public",
                      style: TextStyle(
                        color: publicChoice ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
                // Private button
                GestureDetector(
                  onTap: () {
                    onUpdate?.call(false, 1);
                  },
                  child: Container(
                    width: screenWidth * 0.43,
                    alignment: Alignment.center,
                    child: Text(
                      "Private",
                      style: TextStyle(
                        color: !publicChoice ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
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
