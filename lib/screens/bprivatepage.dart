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
      return Container(
        width: 400,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 119, 196, 122),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          children: [
            Image(
              height: 100,
              width: 40,
              image: AssetImage(""),
            )
          ],
        ),
      );
    }

    // method to add new content inside private bookmark

    Widget AddPrivateContent() {
      return Container();
    }

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
