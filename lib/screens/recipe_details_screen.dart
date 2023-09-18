import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class RecipeDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  RecipeDetailsScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final String instructionsUrl = recipe['instructions'] ?? '';
    final String imageUrl = recipe['image'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['label'] ?? 'Recipe Details'),
      ),
      body: Stack(
        children: <Widget>[
          // Green Background
          Container(
            color: Colors.green[300],
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                mainAxisSize: MainAxisSize.min, // Adjust to min height
                children: <Widget>[
                  Text(
                    recipe['label'] ?? 'No Label',
                    textAlign: TextAlign.center, // Center text horizontally
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (imageUrl.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(
                        imageUrl,
                        width: 200, // Adjust image width as needed
                        height: 150, // Adjust image height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (recipe['ingredientLines'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ingredients:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        for (var ingredient in recipe['ingredientLines'])
                          Text(
                            '- $ingredient',
                            style: TextStyle(fontSize: 16.0),
                          ),
                      ],
                    ),
                  if (instructionsUrl.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _launchInstructionsUrl(instructionsUrl);
                          },
                          child: Text('Click here for instructions'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchInstructionsUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
