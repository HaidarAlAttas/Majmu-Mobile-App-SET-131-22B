import 'package:flutter/material.dart';
import 'package:majmu/services/auth_service.dart';

class GoogleButton extends StatefulWidget {
  final bool registration;
  const GoogleButton({
    super.key,
    required this.registration,
  });

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          // logic implementation
          onTap: () {
            AuthService().signInWithGoogle(context);
          },

          // base for the google sign in button
          child: Container(
            height: ScreenHeight * 0.04,
            width: ScreenWidth * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // google image
                Image(
                  image: AssetImage(
                    "assets/google_logo-google_icongoogle-512.webp",
                  ),
                  height: ScreenHeight * 0.03,
                  width: ScreenWidth * 0.1,
                ),

                // sign in with google text
                Padding(
                  padding: EdgeInsets.only(left: ScreenWidth * 0.01),
                  child: Text(
                    widget.registration
                        ? "Register with google"
                        : "Sign in with Google",
                    style: TextStyle(
                      fontSize: ScreenWidth * 0.036,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
