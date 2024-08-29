// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:majmu/screens/bprivatepage.dart';
import 'package:majmu/screens/bpublicpage.dart';
import 'package:majmu/screens/createpostpage.dart';
import 'package:majmu/screens/homepage.dart';
import 'package:majmu/screens/ilmpage.dart';
import 'package:majmu/screens/settingpage.dart';
import 'package:majmu/theme/theme.dart';
import 'package:majmu/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _post = TextEditingController();

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // design of the baseline for the create content
            width: 400,
            height: 470,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
            ),

            // functions inside the create content button
            child: Column(
              children: [
                // cancel and post button
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // cancel button
                      GestureDetector(
                        // if clicked
                        onTap: () {
                          setState(() {});
                        },

                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Post button
                      GestureDetector(
                        // if clicked
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // row for profile image and textfield
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // profile image
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(

                                  // demo image
                                  image: AssetImage("assets/islamicEvents.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),

                      // textfield to insert content
                      Container(
                        height: 360,
                        width: 340,
                        child: TextField(
                          // controller
                          controller: _post,
                          maxLines:
                              null, // Allows the TextField to have unlimited lines
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),

                            // hint text configuration
                            hintText: "What's on your mind?",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                            border: InputBorder.none,
                          ),

                          // input configuration
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType:
                              TextInputType.multiline, // Allows multiline input
                        ),
                      ),
                    ],
                  ),
                ),

                // to insert picture or location
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 50,
                        width: 380,
                        decoration: BoxDecoration(
                          border: Border(
                            // to make one line on the top of container
                            top: BorderSide(width: 2, color: Colors.black),
                          ),
                        ),

                        // content under the line (photos and locations)
                        child: Row(
                          children: [
                            GestureDetector(
                              // to display the photos (create by 25/8)
                              onTap: () {
                                setState(() {});
                              },

                              // photo icon
                              child: Icon(
                                Icons.photo_size_select_actual_rounded,
                                size: 30,
                              ),
                            ),
                            GestureDetector(
                              // to display the location (create by 25/8)
                              onTap: () {
                                setState(() {});
                              },

                              // location icon
                              child: Icon(
                                Icons.add_location_alt_rounded,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
