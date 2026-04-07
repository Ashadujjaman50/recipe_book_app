import 'package:flutter/material.dart';

import '../../data/service/api_service.dart';
import '../../domain/entities/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();

  List<Recipe> _categoryRecipes = [];
  List<Recipe> get categoryRecipes => _categoryRecipes;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Recipe> _searchResults = [];
  List<Recipe> get searchResults => _searchResults;



  Future<void> fetchRecipesByCategory(String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      _categoryRecipes = await _apiService.getRecipesByCategory(category);
    } catch (e) {
      print('Error fetching category recipes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchRecipes(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      _searchResults = await _apiService.searchRecipes(query);
    } catch (e) {
      print('Error searching recipes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> recipesDetails(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Logic might need to be adjusted if this returns a single recipe details
      await _apiService.recipesDetails(id);
    } catch (e) {
      print('Error fetching recipe details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }
}