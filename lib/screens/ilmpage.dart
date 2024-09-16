// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names

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

// features not added yet:
// - hashtag
// - multi-picture
// - likes and comments

class IlmPage extends StatefulWidget {
  const IlmPage({super.key});

  @override
  State<IlmPage> createState() => _IlmPageState();
}

class _IlmPageState extends State<IlmPage> {
  // constructor
  bool likecolor = false;

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // method fot posts baseline
    Widget PostBaseline() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // post baselines (post base size)
              Container(
                width: screenWidth * 0.97,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),

                // Partitioning for the User part
                //pfp and username,
                //Content's Text,
                //Image
                //like and comment button

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // pfp and username
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.02,
                        top: screenWidth * 0.02,
                        bottom: screenWidth * 0.03,
                      ),
                      child: Row(
                        children: [
                          // profile picture
                          Container(
                            width: screenWidth * 0.08,
                            height: screenHeight * 0.04,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),

                              // demo image
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/ziyarah.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // username
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Text(
                              // demo username
                              "@wiegehtsab",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: screenWidth * 0.036,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // text baseline
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Text(

                          // demo post text/caption
                          "🌟 Meet the incredible Habib Umar bin Hafiz! 🌟 \nDiscover the inspiring journey of this visionary leader, renowned for his wisdom and compassion. From spreading love and knowledge to uplifting communities worldwide, he's a beacon of positivity and change. \nJoin us in celebrating his remarkable contributions to our global muslim community! \n#Inspiration #CommunityLeader #HabibUmarBinHafiz ✨"),
                    ),

                    // Image baseline
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Row(
                        children: [
                          Image(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.9,
                            image: AssetImage(
                              // demo image
                              "assets/ziyarah.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),

                    // likes and comments
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.02,
                          right: screenWidth * 0.02,
                          bottom: screenHeight * 0.02),
                      child: GestureDetector(
                        // demo- need to change bila dah siap post-id so that bila like, bukan semua post akan di like
                        // if clicked
                        onTap: () {
                          setState(() {
                            likecolor = !likecolor;
                          });
                        },

                        child: Row(
                          children: [
                            // like button
                            Padding(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.02),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up_alt_rounded,
                                    color: likecolor == true
                                        ? Colors.blue
                                        : Colors.black,
                                    size: screenWidth * 0.05,
                                  ),
                                  Text(
                                    "Like",
                                    style: TextStyle(
                                      color: likecolor == true
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // comment button
                            // demo- buat functionalities after dah siap post-id

                            GestureDetector(
                              // if clicked
                              onTap: () {
                                setState(() {});
                              },

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.comment_rounded,
                                    color: Colors.black,
                                    size: screenWidth * 0.05,
                                  ),
                                  Text(
                                    "Comment",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                ],
                              ),
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
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(14, (index) {
            return PostBaseline();
          }),
        ),
      ),
    );
  }
}
