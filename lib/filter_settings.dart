class FilterSettings {
  final String selectedDietLabels;
  final String selectedHealthLabels;
  final String selectedCuisineType;
  final String selectedMealType;

  FilterSettings({
    required this.selectedDietLabels,
    required this.selectedHealthLabels,
    required this.selectedCuisineType,
    required this.selectedMealType,
  });

  FilterSettings.empty()
      : selectedDietLabels = '',
        selectedHealthLabels = '',
        selectedCuisineType = '',
        selectedMealType = '';
}
