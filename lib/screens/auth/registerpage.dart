// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:majmu/services/auth_service.dart';
import 'package:path_provider/path_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // class level variable
  // Textfields Input
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _re_password = TextEditingController();

  // checkbox input
  bool checkedValue = false;

  // method to convert an asset image to a File for the pfp
  Future<File> assetImageToFile(String assetPath) async {
    // Load the image as ByteData
    ByteData byteData = await rootBundle.load(assetPath);

    // Convert ByteData to Uint8List
    Uint8List uint8List = byteData.buffer.asUint8List();

    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();

    // Create a file in the temporary directory
    File tempFile = File('${tempDir.path}/temp_profile_picture.jpg');

    // Write the Uint8List data to the file
    await tempFile.writeAsBytes(uint8List);

    return tempFile; // Return the file
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    // textfield sizing
    double TextfieldHeight = ScreenHeight * 0.06;
    double TextfieldWidth = ScreenWidth * 0.75;

    // UI for register page
    return Container(
      height: ScreenHeight,
      width: ScreenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/loginbackground.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        // to view wallpaper on the back
        backgroundColor: Colors.transparent,

        resizeToAvoidBottomInset: false,

        // content inside register page
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // majmu' Icon UI
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: ScreenHeight * 0.01,
                    ),
                    child: Image(
                      image: AssetImage("assets/Majmu'.png"),
                      width: ScreenWidth * 0.3,
                    ),
                  ),

                  // Majmu' title
                  Text(
                    "Majmu'",
                    style: TextStyle(
                      letterSpacing: 0.09,
                      fontSize: ScreenWidth * 0.09,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          // (x,y)
                          offset: Offset(-3.0, 3.5),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: ScreenHeight * 0.01),
                    child: Text(
                      "Register your account now!",
                      style: TextStyle(
                        letterSpacing: 0.09,
                        fontSize: ScreenWidth * 0.047,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            // (x,y)
                            offset: Offset(-3.0, 3.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // textfield for email, password, and re-enter password
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenHeight * 0.02, bottom: ScreenHeight * 0.03),
                    child: Column(
                      children: [
                        // email textfield
                        Padding(
                          padding: EdgeInsets.only(bottom: ScreenHeight * 0.02),
                          child: Container(
                            width: TextfieldWidth,
                            height: TextfieldHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  // (x,y)
                                  offset: Offset(-2.0, 4),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                            child: TextField(
                              // input variable
                              controller: _email,

                              // the color of the cursor
                              cursorColor: Colors.black,

                              //
                              decoration: InputDecoration(
                                // to make the content stays in the middle
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: TextfieldWidth * 0.050,
                                  horizontal: 10.0,
                                ),

                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _email.clear();
                                  },
                                  child: Icon(
                                    Icons.highlight_remove_rounded,
                                    color: Colors.black,
                                  ),
                                ),

                                // hint text configuration
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey,
                                  fontSize: ScreenWidth * 0.032,
                                ),

                                // to remove the underline
                                border: InputBorder.none,
                              ),

                              // input configuration
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenWidth * 0.032,
                              ),
                            ),
                          ),
                        ),

                        // password textfield
                        Padding(
                          padding: EdgeInsets.only(bottom: ScreenHeight * 0.02),
                          child: Container(
                            width: TextfieldWidth,
                            height: TextfieldHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  // (x,y)
                                  offset: Offset(-2.0, 4),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                            child: TextField(
                              // input variable
                              controller: _password,

                              // the color of the cursor
                              cursorColor: Colors.black,

                              // to make the input is "*"
                              obscureText: !checkedValue,

                              //
                              decoration: InputDecoration(
                                // to make the content stays in the middle
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: TextfieldWidth * 0.050,
                                  horizontal: 10.0,
                                ),

                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _password.clear();
                                  },
                                  child: Icon(
                                    Icons.highlight_remove_rounded,
                                    color: Colors.black,
                                  ),
                                ),

                                // hint text configuration
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey,
                                  fontSize: ScreenWidth * 0.032,
                                ),

                                // to remove the underline
                                border: InputBorder.none,
                              ),

                              // input configuration
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenWidth * 0.032),
                            ),
                          ),
                        ),

                        // re-password textfield
                        Container(
                          width: TextfieldWidth,
                          height: TextfieldHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                // (x,y)
                                offset: Offset(-2.0, 4),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                          child: TextField(
                            // input variable
                            controller: _re_password,

                            // the color of the cursor
                            cursorColor: Colors.black,

                            // to make the input is "*"
                            obscureText: !checkedValue,

                            //
                            decoration: InputDecoration(
                              // to make the content stays in the middle
                              contentPadding: EdgeInsets.symmetric(
                                vertical: TextfieldWidth * 0.050,
                                horizontal: 10.0,
                              ),

                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _re_password.clear();
                                },
                                child: Icon(
                                  Icons.highlight_remove_rounded,
                                  color: Colors.black,
                                ),
                              ),

                              // hint text configuration
                              hintText: "Re-enter Password",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.grey,
                                fontSize: ScreenWidth * 0.032,
                              ),

                              // to remove the underline
                              border: InputBorder.none,
                            ),

                            // input configuration
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenWidth * 0.032,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // show password and get started button
                  Container(
                    width: ScreenWidth * 0.73,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // checkbox show password
                        Row(
                          children: [
                            SizedBox(
                              width: ScreenWidth * 0.08,
                              child: Checkbox(
                                // checkbox box color
                                fillColor:
                                    WidgetStateProperty.resolveWith((states) {
                                  // Set the checkbox fill color to white when unchecked
                                  if (checkedValue == false) {
                                    return Colors.white;
                                  }
                                  // Otherwise, keep the default active color
                                  return Colors.blue;
                                }),

                                // the right icon color
                                checkColor: Colors.white,

                                // value of the checkbox
                                value: checkedValue,

                                // logical implementation of the checkbox
                                onChanged: (newValue) {
                                  setState(
                                    () {
                                      checkedValue = newValue!;
                                    },
                                  );
                                },
                              ),
                            ),
                            Text(
                              "Show Password",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),

                        // Get started button
                        GestureDetector(
                          // logical implementation here
                          onTap: () async {
                            // Convert the asset image to a file for pfp
                            File profilePictureFile = await assetImageToFile(
                                'assets/baseProfilePicture.png');

                            // check if the registration textfields is empty or not
                            if (_email.text.isNotEmpty) {
                              if (_password.text.isNotEmpty) {
                                if (_password.text != _re_password.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "An error has occured: the password didn't match"),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  // Attempt to register the user
                                  String? result = await AuthService().register(
                                    email: _email.text,
                                    password: _password.text,
                                    repassword: _re_password.text,
                                    context: context,
                                    profilePictureFile: profilePictureFile,
                                  );

                                  // Check if registration returned an error message
                                  if (result != null && mounted) {
                                    // Display error message in a SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(result),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  } else if (mounted) {
                                    // Display welcome message in a SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Account registered: Welcome to Majmu x PAID app, to unlock the full feature, please link your account with a gmail account;)"),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 10),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                setState(() {
                                  _email.clear();
                                  _password.clear();
                                  _re_password.clear();
                                });
                                // Display error message in a SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please insert password"),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            } else {
                              setState(() {
                                _email.clear();
                                _password.clear();
                                _re_password.clear();
                              });
                              // Display error message in a SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please insert a valid Email address"),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: ScreenHeight * 0.035,
                            width: ScreenWidth * 0.30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 16, 128, 219),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Get Started!",
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

                  Padding(
                    padding: EdgeInsets.only(top: ScreenHeight * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?  ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/loginp");
                          },
                          child: Text(
                            "Login now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
