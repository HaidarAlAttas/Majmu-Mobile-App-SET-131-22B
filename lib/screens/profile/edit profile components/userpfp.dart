// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserPfp extends StatefulWidget {
  final String image;
  final double height;
  final double width;
  final void Function()? onTap;

  const UserPfp({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.onTap,
  });

  @override
  State<UserPfp> createState() => _UserPfpState();
}

class _UserPfpState extends State<UserPfp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(widget.image),
          ),
        ),
      ),
    );
  }
}
