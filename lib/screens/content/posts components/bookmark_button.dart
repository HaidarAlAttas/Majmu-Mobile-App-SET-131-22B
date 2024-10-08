import 'package:flutter/material.dart';

class BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  void Function()? onTap;

  BookmarkButton({
    super.key,
    required this.isBookmarked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
        color: isBookmarked ? Colors.yellow[600] : Colors.grey,
      ),
    );
  }
}
