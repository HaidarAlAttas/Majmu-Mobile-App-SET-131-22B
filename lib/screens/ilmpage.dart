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
              width: 400,
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
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8, bottom: 20),
                    child: Row(
                      children: [
                        // profile picture
                        Container(
                          width: 30,
                          height: 30,
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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            // demo username
                            "@wiegehtsab",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // text baseline
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(

                        // demo post text/caption
                        "🌟 Meet the incredible Habib Umar bin Hafiz! 🌟 \nDiscover the inspiring journey of this visionary leader, renowned for his wisdom and compassion. From spreading love and knowledge to uplifting communities worldwide, he's a beacon of positivity and change. \nJoin us in celebrating his remarkable contributions to our global muslim community! \n#Inspiration #CommunityLeader #HabibUmarBinHafiz ✨"),
                  ),

                  // Image baseline
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Row(
                      children: [
                        Image(
                          height: 350,
                          width: 350,
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
                    padding:
                        const EdgeInsets.only(left: 23, right: 23, bottom: 23),
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
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up_alt_rounded,
                                  color: likecolor == true
                                        ? Colors.blue
                                        : Colors.black,
                                  size: 20,
                                ),
                                Text(
                                  "Like",
                                  style: TextStyle(
                                    color: likecolor == true
                                        ? Colors.blue
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
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
                              setState(() {

                              });
                            },

                            child: Row(
                              children: [
                                Icon(
                                  Icons.comment_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                Text(
                                  "Comment",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // to call the post baseline
            PostBaseline(),
            PostBaseline(),
          ],
        ),
      ),
    );
  }
}
