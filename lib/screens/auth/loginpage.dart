// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:majmu/screens/auth/googlebutton.dart';
import 'package:majmu/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameoremail = TextEditingController();
  TextEditingController _password = TextEditingController();

  // checkbox input
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    // textfield sizing
    double TextfieldHeight = ScreenHeight * 0.06;
    double TextfieldWidth = ScreenWidth * 0.75;

    // UI for login page
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

        resizeToAvoidBottomInset: false, // make the widgets wont go up

        // content inside login page
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // majmu' Icon UI
              Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenHeight * 0.02,
                  top: ScreenHeight * 0.2,
                ),
                child: Image(
                  image: AssetImage("assets/Majmu'.png"),
                  width: ScreenWidth * 0.3,
                ),
              ),

              // Sign In Text UI
              Text(
                "Sign in",
                style: TextStyle(
                  letterSpacing: 0.2,
                  fontSize: ScreenWidth * 0.1,
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

              // textfield for email or username and password
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenHeight * 0.04, bottom: ScreenHeight * 0.03),
                child: Column(
                  children: [
                    // email and username textfield
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
                          controller: _usernameoremail,

                          // the color of the cursor
                          cursorColor: Colors.black,

                          decoration: InputDecoration(
                            // to make the content stays in the middle
                            contentPadding: EdgeInsets.symmetric(
                              vertical: TextfieldWidth * 0.050,
                              horizontal: 10.0,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _usernameoremail.clear();
                              },
                              child: Icon(
                                Icons.highlight_remove_rounded,
                                color: Colors.black,
                              ),
                            ),

                            // hint text configuration
                            hintText: "Email or Username",
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
                        controller: _password,

                        // the color of the cursor
                        cursorColor: Colors.black,

                        // to make the input appear as "*"
                        obscureText: !checkedValue,

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
                          fontSize: ScreenWidth * 0.032,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // back and surf in button
              Container(
                width: ScreenWidth * 0.73,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back button
                    GestureDetector(
                      // logical implementation here
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        height: ScreenHeight * 0.035,
                        width: ScreenWidth * 0.30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 46, 16),
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
                            "Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // surf in button
                    GestureDetector(
                      // logical implementation here
                      onTap: () async {
                        //
                        String? result = await AuthService().login(
                          email: _usernameoremail.text,
                          password: _password.text,
                          context: context,
                        );

                        // Check if login returned an error message
                        if (result != null && mounted) {
                          // Display error message in a SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              duration: result ==
                                      "An error occurred: please log in with gmail if you previously has registered with it"
                                  ? Duration(seconds: 7)
                                  : Duration(seconds: 3),
                            ),
                          );
                          _usernameoremail.clear();
                          _password.clear();
                        } else {}
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
                            "Surf in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Forgot password and create account URL link button
              Padding(
                padding: EdgeInsets.only(top: ScreenHeight * 0.04),
                child: Container(
                  width: ScreenWidth * 0.73,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot your password?  ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenWidth * 0.036,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Forgot Password URL link button
                      GestureDetector(
                        // logical implementation for forgot password
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, "/forgotpasswordp");
                          });
                        },
                        child: Text(
                          "Click here",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: ScreenWidth * 0.036,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // google sign in button
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenHeight * 0.04,
                ),
                child: GoogleButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
