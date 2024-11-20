import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onTap;
  const OtherTextBox({
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
        width: screenWidth * 0.9,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Section name with edit icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
              ],
            ),

            // Main text
            Text(
              text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
