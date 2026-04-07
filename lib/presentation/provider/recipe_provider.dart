import 'package:flutter/material.dart';

import '../../data/service/api_service.dart';
import '../../domain/entities/recipe_entities.dart';

class RecipeProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();

  List<Recipe> _categoryRecipes = [];
  List<Recipe> get categoryRecipes => _categoryRecipes;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Recipe> _searchResults = [];
  List<Recipe> get searchResults => _searchResults;

  bool _isCategoryLoading = false;
  bool get isCategoryLoading => _isCategoryLoading;

  Future<void> fetchRecipesByCategory(String category) async {
    _isCategoryLoading = true; // এখানে ক্যাটাগরি লোডিং ট্রু হবে
    notifyListeners();
    try {
      _categoryRecipes = await _apiService.getRecipesByCategory(category);
    } catch (e) {
      print('Error: $e');
    } finally {
      _isCategoryLoading = false; // লোডিং শেষ
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