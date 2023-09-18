import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/input_screen.dart';
import 'screens/recipe_screen.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: InputScreen(),
      initialRoute: '/intro_screen', // Set the initial route to the intro screen
      routes: {
        '/intro_screen': (context) => IntroScreen(), // Define the intro screen route
        '/input_screen': (context) => InputScreen(), // Define the input screen route
      },// Use InputScreen as the initial screen
    );
  }
}
