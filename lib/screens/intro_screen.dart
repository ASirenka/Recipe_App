import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "Welcome to Recipe App",
        body:
            "This app will help you find recipes based on the ingredients you have at home.",
        image: Center(
          child: Image.asset(
            'assets/images/food1.png',
            width: 300,
            height: 300,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 25.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      PageViewModel(
        title: "How to use the app",
        body:
            "It's simple! Use the filter function to generate recipes based on your own preferences. \n \n Let app do the rest for you!",
        image: Center(
          child: Image.asset(
            'assets/images/food2.png',
            width: 300,
            height: 300,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 25.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      PageViewModel(
        title: "Let's get started!",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Click on the ",
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
            Icon(Icons.arrow_forward),
            Text(
              " button to get started!",
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          ],
        ),
        image: Center(
          child: Image.asset(
            'assets/images/food3.png',
            width: 300,
            height: 300,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 25.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      onDone: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("intro", true);
        if (!mounted) return;
        Navigator.of(context).pushNamed('/input_screen');
      },
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.green,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
