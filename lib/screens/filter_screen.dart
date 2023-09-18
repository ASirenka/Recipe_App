import 'package:flutter/material.dart';
import 'package:Recipe_App/filter_settings.dart';

class FilterScreen extends StatefulWidget {
  final FilterSettings filterSettings;
  final Function(FilterSettings) onSaveFilters;
  final Function() onClearFilters;

  const FilterScreen({
    Key? key,
    required this.filterSettings,
    required this.onSaveFilters,
    required this.onClearFilters,
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> selectedDietLabels = [];
  List<String> selectedHealthLabels = [];
  List<String> selectedCuisineType = [];
  List<String> selectedMealType = [];

  final List<String> dietLabels = [
    'balanced',
    'high-fiber',
    'high-protein',
    'low-carb',
    'low-fat',
    'low-sodium',
  ];

  final List<String> healthLabels = [
    'alcohol-cocktail',
    'alcohol-free',
    'celery-free',
    'crustacean-free',
    'dairy-free',
    'DASH',
    'egg-free',
    'fish-free',
    'fodmap-free',
    'gluten-free',
    'immuno-supportive',
    'keto-friendly',
    'kidney-friendly',
    'kosher',
    'low-potassium',
    'low-sugar',
    'lupine-free',
    'Mediterranean',
    'mollusk-free',
    'mustard-free',
    'No-oil-added',
    'paleo',
    'peanut-free',
    'pecatarian',
    'pork-free',
    'red-meat-free',
    'sesame-free',
    'shellfish-free',
    'soy-free',
    'sugar-conscious',
    'sulfite-free',
    'tree-nut-free',
    'vegan',
    'vegetarian',
    'wheat-free',
  ];

  final List<String> cuisineTypes = [
    'american',
    'asian',
    'british',
    'caribbean',
    'central europe',
    'chinese',
    'eastern europe',
    'french',
    'greek',
    'indian',
    'italian',
    'japanese',
    'korean',
    'kosher',
    'mediterranean',
    'mexican',
    'middle eastern',
    'nordic',
    'south american',
    'south east asian',
    'world',
  ];

  final List<String> mealTypes = [
    'breakfast',
    'brunch',
    'lunch/dinner',
    'snack',
    'teatime',
  ];

  // Flag to track if filters were applied
  bool filtersApplied = false;

  @override
  void initState() {
    super.initState();
    selectedDietLabels = widget.filterSettings.selectedDietLabels.split(',');
    selectedHealthLabels =
        widget.filterSettings.selectedHealthLabels.split(',');
    selectedCuisineType = widget.filterSettings.selectedCuisineType.split(',');
    selectedMealType = widget.filterSettings.selectedMealType.split(',');
  }

  // Method to apply filters and save settings
  void _applyFiltersAndSave() {
    // Create FilterSettings object with selected values
    final FilterSettings appliedFilters = FilterSettings(
      selectedDietLabels:
          selectedDietLabels.join('&').replaceFirst(RegExp('&'), ''),
      selectedHealthLabels:
          selectedHealthLabels.join('&').replaceFirst(RegExp('&'), ''),
      selectedCuisineType:
          selectedCuisineType.join('&').replaceFirst(RegExp('&'), ''),
      selectedMealType:
          selectedMealType.join('&').replaceFirst(RegExp('&'), ''),
    );
    // Save filter settings
    widget.onSaveFilters(appliedFilters);
    filtersApplied = true; // Set the flag to indicate filters were applied
  }

  // Handle back button press
  Future<bool> onWillPop() async {
    // Clear the selected filters if they were not applied
    if (!filtersApplied) {
      widget.onClearFilters();
    }
    return true;
  }

  void _showModalFilterDialog(
    List<String> options,
    List<String> selectedValues,
    Function(List<String>) onApply,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Column(
                children: [
                  AppBar(
                    title: Text('Select Options'),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.done),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onApply(selectedValues);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options[index];
                        final bool isSelected = selectedValues.contains(option);

                        return ListTile(
                          title: Text(option),
                          trailing: isSelected
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : Icon(Icons.check_circle_outline),
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedValues.remove(option);
                              } else {
                                selectedValues.add(option);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop, // Register the onWillPop callback
      child: Scaffold(
        appBar: AppBar(
          title: Text('Filter Recipes'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Diet Labels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center, // This will center the chips horizontally
                children: dietLabels.map((label) {
                  final bool isSelected = selectedDietLabels.contains(label);

                  return FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDietLabels.add(label);
                        } else {
                          selectedDietLabels.remove(label);
                        }
                      });
                    },
                    backgroundColor:
                        isSelected ? Colors.green : Colors.green[100],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              Divider(),
              Text(
                'Health Labels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  _showModalFilterDialog(
                    healthLabels,
                    selectedHealthLabels,
                    (selectedValues) {
                      setState(() {
                        selectedHealthLabels = selectedValues;
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400], // Background color
                ),
                child: Text('Select Health Labels'),
              ),
              Divider(),
              Text(
                'Cuisine Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  _showModalFilterDialog(
                    cuisineTypes,
                    selectedCuisineType,
                    (selectedValues) {
                      setState(() {
                        selectedCuisineType = selectedValues;
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400], // Background color
                ),
                child: Text('Select Cuisine Types'),
              ),
              Divider(),
              Text(
                'Meal Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center, // This will center the chips horizontally
                children: mealTypes.map((type) {
                  final bool isSelected = selectedMealType.contains(type);

                  return FilterChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedMealType.add(type);
                        } else {
                          selectedMealType.remove(type);
                        }
                      });
                    },
                    backgroundColor:
                        isSelected ? Colors.green : Colors.green[100],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Adjust as needed
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _applyFiltersAndSave();
                      Navigator.of(context).pop(); // Close the filter drawer
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20.0), // Adjust padding as needed
                    ),
                    child: Text('Apply Filters'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Clear the selected filters
                      widget.onClearFilters();
                      Navigator.of(context).pop(); // Close the filter drawer
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[50], // Change the background color
                      onPrimary: Colors.black, // Change the text color
                      padding: EdgeInsets.all(20.0), // Adjust padding as needed
                    ),
                    child: Text('Clear Filters'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
