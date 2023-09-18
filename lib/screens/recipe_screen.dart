import 'package:flutter/material.dart';
import 'package:Recipe_App/screens/recipe_details_screen.dart';

class RecipeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recipes;

  RecipeScreen({required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          if (recipe != null && recipe['label'] != null) {
            final String label = recipe['label'];
            final String source = recipe['source'] ?? 'Unknown Source';
            final String imageUrl = recipe['image'] ?? 'https://example.com/placeholder.jpg';
            final List<dynamic> ingredientLines = recipe['ingredientLines'] ?? [];
            final String instructions = recipe['instructions'] ?? ''; // Get instructions if available

            return ListTile(
              title: Text(label),
              subtitle: Text(source),
              leading: imageUrl.isNotEmpty ? Image.network(imageUrl) : SizedBox.shrink(),
              onTap: () {
                // Navigate to the recipe details screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailsScreen(
                      recipe: recipe,
                    ),
                  ),
                );
              },
            );
          } else {
            // Handle the case where recipe data is missing or null.
            return ListTile(
              title: Text('Recipe data is missing'),
            );
          }
        },
      ),
    );
  }
}
