// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code
import 'package:flutter/material.dart';

// Create a dialog for settings
Future profileDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      content: Container(
        height: 230,
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
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 145,
                width: 350,
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
                        width: 330,
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
                              padding: const EdgeInsets.only(
                                  left: 25, right: 8, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // edit profile icon
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // edit profile text
                                  Text(
                                    "edit profile",
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


                    // your posts button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        Navigator.pushNamed(context, "/yourpostsp");
                      },
                      child: Container(
                        width: 330,
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
                              padding: const EdgeInsets.only(
                                  left: 25, right: 8, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // your posts button icon
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Icon(
                                      Icons.photo_size_select_large_rounded,
                                      size: 30,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  // your posts button text
                                  Text(
                                    "Your posts",
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


                    // log out button
                    GestureDetector(
                      onTap: () {
                        // Implement your logic here
                        Navigator.pushNamed(context, "/logoutp");
                      },
                      child: Container(
                        width: 330,
                        // logout button icon and text
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 8, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // log out button icon
                                  Padding(
                                    padding: const EdgeInsets.only(right: 22.0),
                                    child: Icon(
                                      Icons.logout_rounded,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                  // Log out button text
                                  Text(
                                    "Logout",
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
          ],
        ),
      ),
    ),
  );
}
