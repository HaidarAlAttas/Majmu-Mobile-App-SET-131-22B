import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigatorBookmark extends StatelessWidget {
  final publicChoice;
  final puborpriv;
  final Function? onUpdate;
  const NavigatorBookmark({
    super.key,
    required this.onUpdate,
    required this.publicChoice,
    required this.puborpriv,
  });

  @override
  Widget build(BuildContext context) {
    // to create accurate sizing of the phone size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.03,
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
                onUpdate!(true, 0);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.02, right: screenWidth * 0.01),
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: publicChoice
                        ? Colors.black
                        : Colors.white, // Change color based on selection
                  ),
                  child: Center(
                    child: Text(
                      "Public",
                      style: TextStyle(
                        color: publicChoice
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
                onUpdate!(false, 1);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.02, right: screenWidth * 0.01),
                child: Container(
                  height: screenHeight * 0.035,
                  width: screenWidth * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: publicChoice
                        ? Colors.white
                        : Colors.black, // Change color based on selection
                  ),
                  child: Center(
                    child: Text(
                      "Private",
                      style: TextStyle(
                        color: publicChoice
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
