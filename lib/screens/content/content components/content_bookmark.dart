import 'package:flutter/material.dart';

class ContentBookmarkButton extends StatelessWidget {
  final onTap;
  final bool isBookmarked;

  const ContentBookmarkButton({
    super.key,
    required this.onTap,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    // variable to make it compatible with devices
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
        color: isBookmarked ? Colors.yellow[600] : Colors.grey,
      ),
    );
  }
}
