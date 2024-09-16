// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code
import 'package:flutter/material.dart';

// Create a dialog for settings
Future profileDialog(BuildContext context) {
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
            ? screenHeight * 0.30
            : screenHeight * 0.28,
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
                  padding: EdgeInsets.only(left: screenWidth * 0.08),
                  child: Text(
                    "Profile",
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

            // edit profile, your post, and logout button container
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02),
              child: Container(
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
                    // edit profile button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        Navigator.pushNamed(context, "/editprofilep");
                      },
                      child: Container(
                        width: screenWidth * 0.7,
                        height: screenHeight <= screenWidth * 2
                            ? screenHeight * 0.06
                            : screenHeight * 0.055,
                        decoration: BoxDecoration(
                          // To create a line below edit profile button
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.grey),
                          ),
                        ),
                        // edit profile button icon and text
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.017,
                                top: screenWidth * 0.015,
                                bottom: screenWidth * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // edit profile icon
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02),
                                    child: Icon(
                                      Icons.edit,
                                      size: screenWidth * 0.08,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // edit profile text
                                  Text(
                                    "edit profile",
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

                    // your posts button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        Navigator.pushNamed(context, "/yourpostsp");
                      },
                      child: Container(
                        width: screenWidth * 0.7,
                        height: screenHeight <= screenWidth * 2
                            ? screenHeight * 0.06
                            : screenHeight * 0.055,
                        decoration: BoxDecoration(
                          // To create a line below your post button
                          border: Border(
                            bottom: BorderSide(width: 2, color: Colors.grey),
                          ),
                        ),
                        // your posts button icon and text
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.017,
                                top: screenWidth * 0.015,
                                bottom: screenWidth * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // your posts button icon
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02),
                                    child: Icon(
                                      Icons.photo_size_select_large_rounded,
                                      size: screenWidth * 0.08,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  // your posts button text
                                  Text(
                                    "Your posts",
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

                    // log out button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        Navigator.pushNamed(context, "/logoutp");
                      },
                      child: Container(
                        width: screenWidth * 0.7,
                        height: screenHeight <= screenWidth * 2
                            ? screenHeight * 0.06
                            : screenHeight * 0.055,
                        // logout button icon and text
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.017,
                                top: screenWidth * 0.015,
                                bottom: screenWidth * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // log out button icon
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.02),
                                    child: Icon(
                                      Icons.logout_rounded,
                                      size: screenWidth * 0.08,
                                      color: Colors.red,
                                    ),
                                  ),
                                  // Log out button text
                                  Text(
                                    "Logout",
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
            ),
          ],
        ),
      ),
    ),
  );
}
