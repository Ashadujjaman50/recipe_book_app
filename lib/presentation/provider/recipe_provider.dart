import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/service/api_service.dart';
import '../../data/model/recipe_model.dart';
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

  List<Recipe> _savedRecipes = [];
  List<Recipe> get savedRecipes => _savedRecipes;

  RecipeProvider() {
    loadSavedRecipes();
  }

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

  // Local Cache Logic for Saved Recipes
  Future<void> toggleSaveRecipe(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final isSaved = _savedRecipes.any((r) => r.id == recipe.id);

    if (isSaved) {
      _savedRecipes.removeWhere((r) => r.id == recipe.id);
    } else {
      _savedRecipes.add(recipe);
    }

    List<String> savedList = _savedRecipes.map((r) => jsonEncode({
      'id': r.id,
      'title': r.title,
      'image': r.image,
    })).toList();

    await prefs.setStringList('saved_recipes', savedList);
    notifyListeners();
  }

  Future<void> loadSavedRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList('saved_recipes');

    if (savedList != null) {
      _savedRecipes = savedList.map((item) {
        final Map<String, dynamic> data = jsonDecode(item);
        return RecipeModel.fromJson(data);
      }).toList();
      notifyListeners();
    }
  }

  bool isRecipeSaved(int id) {
    return _savedRecipes.any((r) => r.id == id);
  }
}
