// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code
import 'package:flutter/material.dart';
import 'package:majmu/screens/searchpage.dart';

// Create a dialog for settings
Future settingsDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      content: Container(
        height: 380,
        width: 400,
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
                  padding: const EdgeInsets.all(8.0),
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
              padding:
                  const EdgeInsets.only(top: 20, bottom: 10, left: 8, right: 8),
              child: Container(
                height: 120,
                width: 350,
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
                        Navigator.pushNamed(context, "/searchp");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Majmu' Image
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image(
                                    image: AssetImage("assets/Majmu'.png"),
                                    height: 45,
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
                                          fontSize: 20,
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
                              size: 30,
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
                      },
                      child: Container(
                        width: 330,
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
                              padding: const EdgeInsets.only(
                                  left: 25, right: 8, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Account button icon
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Icon(
                                      Icons.manage_accounts_rounded,
                                      size: 30,
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
                              size: 30,
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
              height: 145,
              width: 350,
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
                    },
                    child: Container(
                      width: 330,
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
                            padding: const EdgeInsets.only(
                                left: 25, right: 8, top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Storage and data icon
                                Padding(
                                  padding: const EdgeInsets.only(right: 22.0),
                                  child: Icon(
                                    Icons.sd_storage_rounded,
                                    size: 30,
                                    color: Colors.orange,
                                  ),
                                ),
                                // Storage and data text
                                Text(
                                  "Storage and data",
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
                            size: 30,
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
                    },
                    child: Container(
                      width: 330,
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
                            padding: const EdgeInsets.only(
                                left: 25, right: 8, top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Theme button icon
                                Padding(
                                  padding: const EdgeInsets.only(right: 22.0),
                                  child: Icon(
                                    Icons.format_paint_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                // Theme button text
                                Text(
                                  "Theme",
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
                            size: 30,
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
                    },
                    child: Container(
                      width: 330,
                      // Customer Service button icon and text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 8, top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Customer Service button icon
                                Padding(
                                  padding: const EdgeInsets.only(right: 22.0),
                                  child: Icon(
                                    Icons.quick_contacts_dialer_outlined,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                ),
                                // Customer Service button text
                                Text(
                                  "Customer Services",
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
                            size: 30,
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
