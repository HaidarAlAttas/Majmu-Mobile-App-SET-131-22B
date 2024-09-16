// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class BPrivatePage extends StatefulWidget {
  const BPrivatePage({super.key});

  @override
  State<BPrivatePage> createState() => _BPrivatePageState();
}

class _BPrivatePageState extends State<BPrivatePage> {
  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // create method to apply a blueprint for the bookmarks (public)

    // private content box
    Widget PrivateContent() {
      return GestureDetector(
        // action to do after clicked
        onTap: () {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),

          // box design
          child: Container(
            width: screenWidth * 0.94,
            padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.02,
                left: screenWidth * 0.02,
                right: screenWidth * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 201, 218, 162),
              border: Border.all(color: Colors.black, width: 2),
            ),

            // content descriptions
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // the document image cover
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
                  child: Image(
                    height: screenHeight * 0.26,
                    width: screenWidth * 0.37,
                    fit: BoxFit.cover,

                    // demo file image
                    image: AssetImage("assets/RatibAlattas.jpg"),
                  ),
                ),

                // for title, date created, and descriptions of the bookmark
                // demo file description
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  demo title
                    Text(
                      "Ratib Alattas.pdf",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    // demo date n time
                    Text(
                      "created: 2/3/2024",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // demo description
                    Text(
                      "Description: \n- Daily dua' \n- After Maghrib's prayer",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: screenWidth * 0.036,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    // method to add new content inside private bookmark

    Widget AddPrivateContent() {
      return GestureDetector(
        // actions after the button is clicked
        onTap: () {
          setState(() {
            Navigator.of(context).pushNamed("/docscan");
          });
        },

        // box design
        child: Container(
          width: screenWidth * 0.94,
          height: screenHeight * 0.29,
          padding: EdgeInsets.only(
              top: screenHeight * 0.02,
              bottom: screenHeight * 0.02,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 201, 218, 162),
            border: Border.all(color: Colors.black, width: 2),
          ),

          // add logo and title

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.document_scanner_rounded,
                color: Colors.black,
                size: 120,
              ),
              Text(
                "Add New",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ],
          ),
        ),
      );
    }

    // page base
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PrivateContent(),
            AddPrivateContent(),
          ],
        ),
      ),
    );
  }
}
