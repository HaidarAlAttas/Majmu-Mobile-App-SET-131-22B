// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code
import 'package:flutter/material.dart';
import 'package:majmu/screens/profilepage.dart';
import 'package:majmu/screens/searchpage.dart';

// Create a dialog for settings
Future settingsDialog(BuildContext context) {
  // variable to make it compatible with devices
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      content: Container(
        height: screenHeight <= screenWidth * 2
            ? screenHeight * 0.5
            : screenHeight * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 36, 36, 36),
        ),
        child: Column(
          children: [
            // Settings title
            Row(
              children: [
                // Spacer to push the Settings text to the center
                Spacer(flex: 3),

                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Spacer to push the done button to the right
                Spacer(flex: 2),

                TextButton(
                  onPressed: () {
                    // Handle the done action
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),

            // Majmu' and account container
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02),
              child: Container(
                // to make sure it's compatible with phone size that is distorted on height like iphone 8 etc.
                height: screenHeight <= screenWidth * 2
                    ? screenHeight * 0.16
                    : screenHeight * 0.13,

                width: screenWidth * 0.74,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 85, 84, 84),
                  borderRadius: BorderRadius.circular(20),
                ),
                // Majmu' and account button
                child: Column(
                  children: [
                    // Majmu' button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        // demo
                        Navigator.pushNamed(context, "/biographiesnreferencep");
                      },
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Majmu' Image
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.01),
                                  child: Image(
                                    image: AssetImage("assets/Majmu'.png"),
                                    height: screenWidth * 0.1,
                                  ),
                                ),
                                // Text for Majmu' button
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Majmu' text
                                    Text(
                                      "Majmu'",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.05,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Sunnah origin text
                                    Text(
                                      "Sunnah Origin",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Icon for next
                            Icon(
                              Icons.navigate_next_rounded,
                              size: screenWidth * 0.08,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Account button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        Navigator.pop(context);
                        profileDialog(context);
                      },
                      child: Container(
                        width: screenWidth * 0.7,
                        decoration: BoxDecoration(
                          // To create a line on top of account button
                          border: Border(
                            top: BorderSide(width: 2, color: Colors.grey),
                          ),
                        ),
                        // Account button icon and text
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                  right: screenWidth * 0.017,
                                  top: screenWidth * 0.015,
                                  bottom: screenWidth * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Account button icon
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02),
                                    child: Icon(
                                      Icons.manage_accounts_rounded,
                                      size: screenWidth * 0.08,
                                      color: Colors.green,
                                    ),
                                  ),
                                  // Account button text
                                  Text(
                                    "Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Icon for next
                            Icon(
                              Icons.navigate_next_rounded,
                              size: screenWidth * 0.08,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Storage and data, theme, customer service button container
            Container(
              height: screenHeight <= screenWidth * 2
                  ? screenHeight * 0.18
                  : screenHeight * 0.17,
              width: screenWidth * 0.74,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 85, 84, 84),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Storage and data button
                  GestureDetector(
                    onTap: () {
                      // Implement your logic here
                      Navigator.pushNamed(context, "/storagep");
                    },
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenHeight <= screenWidth * 2
                          ? screenHeight * 0.06
                          : screenHeight * 0.055,
                      decoration: BoxDecoration(
                        // To create a line on top of storage and data button
                        border: Border(
                          bottom: BorderSide(width: 2, color: Colors.grey),
                        ),
                      ),
                      // Storage and data button icon and text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.017,
                                top: screenWidth * 0.015,
                                bottom: screenWidth * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Storage and data icon
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: Icon(
                                    Icons.sd_storage_rounded,
                                    size: screenWidth * 0.08,
                                    color: Colors.orange,
                                  ),
                                ),
                                // Storage and data text
                                Text(
                                  "Storage and data",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Icon for next
                          Icon(
                            Icons.navigate_next_rounded,
                            size: screenWidth * 0.08,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Theme button
                  GestureDetector(
                    onTap: () {
                      // Implement your logic here
                      Navigator.pushNamed(context, "/themep");
                    },
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenHeight <= screenWidth * 2
                          ? screenHeight * 0.06
                          : screenHeight * 0.055,

                      decoration: BoxDecoration(
                        // To create a line on top of theme button
                        border: Border(
                          bottom: BorderSide(width: 2, color: Colors.grey),
                        ),
                      ),
                      // Theme button icon and text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.017,
                                top: screenWidth * 0.015,
                                bottom: screenWidth * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Theme button icon
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: Icon(
                                    Icons.format_paint_rounded,
                                    size: screenWidth * 0.08,
                                    color: Colors.white,
                                  ),
                                ),
                                // Theme button text
                                Text(
                                  "Theme",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Icon for next
                          Icon(
                            Icons.navigate_next_rounded,
                            size: screenWidth * 0.08,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Customer Service
                  GestureDetector(
                    onTap: () {
                      // Implement your logic here
                      Navigator.pushNamed(context, "/customerservp");
                    },
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenHeight <= screenWidth * 2
                          ? screenHeight * 0.06
                          : screenHeight * 0.055,

                      // Customer Service button icon and text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.017,
                                top: screenWidth * 0.015,
                                bottom: screenWidth * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Customer Service button icon
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.02),
                                  child: Icon(
                                    Icons.quick_contacts_dialer_outlined,
                                    size: screenWidth * 0.08,
                                    color: Colors.blue,
                                  ),
                                ),
                                // Customer Service button text
                                Text(
                                  "Customer Services",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Icon for next
                          Icon(
                            Icons.navigate_next_rounded,
                            size: screenWidth * 0.08,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
