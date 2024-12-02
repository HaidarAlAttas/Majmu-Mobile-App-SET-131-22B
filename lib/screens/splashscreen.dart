import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/staylogged");
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/loginbackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(height: screenHeight * 0.35), // Space at the top
              Center(
                child: Column(
                  children: [
                    // Logo
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Image.asset(
                        "assets/Majmu'.png",
                        width: screenWidth * 0.6, // Adjust size
                      ),
                    ),

                    // "By: SunnahOrigin" Text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'By:',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: screenWidth * 0.05,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: 'SunnahOrigin',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: screenWidth * 0.08,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(4, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ],
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
