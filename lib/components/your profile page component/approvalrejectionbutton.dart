import 'package:flutter/material.dart';

class ApprovalRejectionButtons extends StatelessWidget {
  final bool approvedChoice;
  final int appOrRej;
  final Function(bool, int)? onUpdate;

  const ApprovalRejectionButtons({
    Key? key,
    required this.approvedChoice,
    required this.appOrRej,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.02,
      ),
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
        child: Stack(
          children: [
            // Animated selection indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: approvedChoice ? 0 : screenWidth * 0.5 - screenWidth * 0.04,
              top: 0,
              bottom: 0,
              child: Container(
                width: screenWidth * 0.47,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Approved button
                GestureDetector(
                  onTap: () {
                    onUpdate?.call(true, 0);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: screenWidth * 0.43,
                    alignment: Alignment.center,
                    child: Text(
                      "Approved",
                      style: TextStyle(
                        color: approvedChoice ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                // Rejected button
                GestureDetector(
                  onTap: () {
                    onUpdate?.call(false, 1);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: screenWidth * 0.43,
                    alignment: Alignment.center,
                    child: Text(
                      "Rejected",
                      style: TextStyle(
                        color: !approvedChoice ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
