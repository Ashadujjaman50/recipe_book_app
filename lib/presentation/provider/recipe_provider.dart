import 'package:flutter/material.dart';

import '../../data/service/api_service.dart';
import '../../domain/entities/recipe_entities.dart';
import '../../domain/entities/recipe_details_entities.dart';

class RecipeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Recipe> _categoryRecipes = [];
  List<Recipe> get categoryRecipes => _categoryRecipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Recipe> _searchResults = [];
  List<Recipe> get searchResults => _searchResults;

  bool _isCategoryLoading = false;
  bool get isCategoryLoading => _isCategoryLoading;

  RecipeDetails? _selectedRecipe;
  RecipeDetails? get selectedRecipe => _selectedRecipe;

  bool _isDetailsLoading = false;
  bool get isDetailsLoading => _isDetailsLoading;

  Future<void> fetchRecipesByCategory(String category) async {
    _isCategoryLoading = true;
    notifyListeners();
    try {
      _categoryRecipes = await _apiService.getRecipesByCategory(category);
    } catch (e) {
      print('Error: $e');
    } finally {
      _isCategoryLoading = false;
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

  Future<void> fetchRecipeDetails(int id) async {
    _isDetailsLoading = true;
    _selectedRecipe = null;
    notifyListeners();
    try {
      _selectedRecipe = await _apiService.getRecipeDetails(id);
    } catch (e) {
      print('Error fetching recipe details: $e');
    } finally {
      _isDetailsLoading = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }
}
