import 'package:flutter/material.dart';
import 'package:majmu/components/tutorial%20page%20components/bookmark_tutorial.dart';
import 'package:majmu/components/tutorial%20page%20components/homepage_tutorial.dart';
import 'package:majmu/components/tutorial%20page%20components/ilmpage_tutorial.dart';
import 'package:majmu/services/auth_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  // controller to keep track on what page we are in
  final PageController _pageController = PageController();

  // keep track if we're in the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView to display the tutorial screens
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              HomepageTutorial(),
              BookmarkTutorial(),
              IlmpageTutorial(),
            ],
          ),

          // Page indicator and buttons
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                ElevatedButton(
                  onPressed: () {
                    _pageController.jumpToPage(2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Page indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const ColorTransitionEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.white,
                  ),
                ),

                // Next/Done button
                ElevatedButton(
                  onPressed: () {
                    //
                    if (onLastPage) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StayLogged()),
                      );
                    } else {
                      // change to nextr page
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    onLastPage ? "Surf in" : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
