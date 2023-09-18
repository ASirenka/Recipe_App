import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String appId;
  final String appKey;
  final String apiUrl;

  ApiService(this.appId, this.appKey, this.apiUrl);

  Future<List<Map<String, dynamic>>> fetchRecipes(
      String ingredients,
      String selectedDietLabels,
      String selectedHealthLabels,
      String selectedCuisineType,
      String selectedMealType,
      ) async {
    try {
      final StringBuffer url = StringBuffer('$apiUrl?q=$ingredients&app_id=$appId&app_key=$appKey');

      // Append filter parameters to the URL
      if (selectedDietLabels.isNotEmpty) {
        url.write('&diet=$selectedDietLabels');
      }

      if (selectedHealthLabels.isNotEmpty) {
        url.write('&health=$selectedHealthLabels');
      }

      if (selectedCuisineType.isNotEmpty) {
        url.write('&cuisineType=$selectedCuisineType');
      }

      if (selectedMealType.isNotEmpty) {
        url.write('&mealType=$selectedMealType');
      }

      print(url);

      final response = await http.get(
        Uri.parse(url.toString()),
        headers: {
        'Content-Type': 'application/json',
      },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['hits'] is List) {
          final List<Map<String, dynamic>> recipes = (data['hits'] as List)
              .map((hit) {
            final Map<String, dynamic> recipe =
            hit['recipe'] as Map<String, dynamic>;
            final String instructions = recipe['url'] ?? ''; // Get the instructions URL
            return {
              ...recipe,
              'instructions': instructions,
            };
          })
              .toList();
          return recipes;
        }
      }

      throw Exception('Failed to load recipes');
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow the exception to handle it in the calling widget.
    }
  }
}
