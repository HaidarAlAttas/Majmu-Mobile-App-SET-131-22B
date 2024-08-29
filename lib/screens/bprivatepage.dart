// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';


class BPrivatePage extends StatefulWidget {
  const BPrivatePage({super.key});

  @override
  State<BPrivatePage> createState() => _BPrivatePageState();
}

class _BPrivatePageState extends State<BPrivatePage> {
  @override
  Widget build(BuildContext context) {
    // create method to apply a blueprint for the bookmarks (public)

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
            width: 400,
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
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
                    height: 240,
                    width: 160,
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
                    // title
                    Text(
                      "Ratib Alattas.pdf",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    // date n time
                    Text(
                      "created: 2/3/2024",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // description
                    Text(
                      "Description: \n- Daily dua' \n- After Maghrib's prayer",
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
          width: 400,
          height: 300,
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
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
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20
                ),
              ),
            ],
          ),
        ),
      );
    }

    // page base
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
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
