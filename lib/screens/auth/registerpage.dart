// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:majmu/services/auth_service.dart';

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

  @override
  Widget build(BuildContext context) {
    // wallpaper size
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
            image: AssetImage("assets/loginbackground.png"), fit: BoxFit.fill),
      ),
      child: Scaffold(
        // to view wallpaper on the back
        backgroundColor: Colors.transparent,

        // content inside register page
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // majmu' Icon UI
              Padding(
                padding: EdgeInsets.only(bottom: ScreenHeight * 0.02),
                child: Image(
                  image: AssetImage("assets/Majmu'.png"),
                  width: ScreenWidth * 0.3,
                ),
              ),

              // Sign In Text UI
              Text(
                "Create a Majmu' account",
                style: TextStyle(
                  letterSpacing: 0.09,
                  fontSize: ScreenWidth * 0.058,
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

              // textfield for email, password, and re-enter password
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenHeight * 0.06, bottom: ScreenHeight * 0.03),
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

                            // hint text configuration
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                              fontSize: 13,
                            ),

                            // to remove the underline
                            border: InputBorder.none,
                          ),

                          // input configuration
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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

                            // hint text configuration
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                              fontSize: 13,
                            ),

                            // to remove the underline
                            border: InputBorder.none,
                          ),

                          // input configuration
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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

                          // hint text configuration
                          hintText: "Re-enter Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                            fontSize: 13,
                          ),

                          // to remove the underline
                          border: InputBorder.none,
                        ),

                        // input configuration
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // back and get started button
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
                        width: ScreenWidth * 0.17,
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

                    // Get started button
                    GestureDetector(
                      // logical implementation here
                      onTap: () async {
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
                          } else {
                            // Display welcome message in a SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Account registered: Welcome to Majmu x PAID app, feel free to explore more in the application ;)"),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 10),
                              ),
                            );
                          }
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
            ],
          ),
        ),
      ),
    );
  }
}
