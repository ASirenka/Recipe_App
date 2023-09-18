import 'package:flutter/material.dart';
import 'package:Recipe_App/api_service.dart';
import 'package:Recipe_App/screens/filter_screen.dart';
import 'package:Recipe_App/screens/recipe_screen.dart';
import 'package:Recipe_App/filter_settings.dart';
import '';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}


class _InputScreenState extends State<InputScreen> {
  TextEditingController _ingredientController = TextEditingController();
  ApiService _apiService = ApiService(
    'f3e4e090',
    '0c522b65bb35faf0411096b69b5af82c',
    'https://api.edamam.com/search',
  );

  FilterSettings _filterSettings = FilterSettings(
    selectedDietLabels: '',
    selectedHealthLabels: '',
    selectedCuisineType: '',
    selectedMealType: '',
  );


  Future<void> _getRecipes() async {
    final String ingredients = _ingredientController.text;

    try {
      print('API Request: ingredients=$ingredients '
          'diet=${_filterSettings.selectedDietLabels} '
          'health=${_filterSettings.selectedHealthLabels} '
          'cuisine=${_filterSettings.selectedCuisineType} '
          'mealType=${_filterSettings.selectedMealType}');

      final List<Map<String, dynamic>> recipes = await _apiService.fetchRecipes(
        ingredients,
        _filterSettings.selectedDietLabels,
        _filterSettings.selectedHealthLabels,
        _filterSettings.selectedCuisineType,
        _filterSettings.selectedMealType,
      );

      print('API Response: $recipes');

      if (recipes.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(recipes: recipes),
          ),
        );
      } else {
        // Handle the case where no recipes were found.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No recipes found for the provided ingredients.'),
          ),
        );
      }
    } catch (e) {
      print('Error in API request: $e');
      // Handle API request errors here.
      // You can show an error message to the user if needed.

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              final settings = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterScreen(
                    filterSettings: _filterSettings,
                    onSaveFilters: (appliedFilters) {
                      FilterSettings settings = appliedFilters as FilterSettings;
                      setState(() {
                        _filterSettings = settings;
                      });
                    },
                    onClearFilters: () {
                      // Clear the selected filters here
                      setState(() {
                        _filterSettings = FilterSettings.empty();
                      });
                    },
                  ),
                ),
              );


              // Check if filters were applied and update the UI accordingly
              if (settings != null) {
                _getRecipes();
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/food4.png'),
            fit: BoxFit.fitWidth, // Adjust this based on your image dimensions
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter Ingredients:',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _ingredientController,
                  decoration: InputDecoration(
                    hintText: 'e.g., chicken, rice, onions',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _getRecipes,
                  child: Text('Get Recipes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
