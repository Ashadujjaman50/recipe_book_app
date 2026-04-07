import 'package:flutter/material.dart';

import '../../data/service/api_service.dart';
import '../../domain/entities/recipe_entities.dart';

class RandomRecipeProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();

  List<Recipe> _weeklyRecipes = [];
  List<Recipe> get weeklyRecipes => _weeklyRecipes;


  bool _isWeeklyLoading = false;
  bool get isWeeklyLoading => _isWeeklyLoading;


  Future<void> fetchRandomRecipes() async {
    _isWeeklyLoading = true;
    notifyListeners();
    try {
      _weeklyRecipes = (await _apiService.getRandomRecipes()).cast<Recipe>();
    } catch (e) {
      print('Error fetching random recipes: $e');
    } finally {
      _isWeeklyLoading = false;
      notifyListeners();
    }
  }

}