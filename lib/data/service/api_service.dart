import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/app_strings.dart';
import '../../domain/entities/recipe_entities.dart';
import '../model/recipe_details_model.dart';
import '../model/recipe_model.dart';

class ApiService {

  Future<List<Recipe>> getRecipesByCategory(String category) async {
    final url = category == 'All'
        ? '${AppStrings.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}'
        : '${AppStrings.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}&cuisine=$category';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse(
        '${AppStrings.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}&query=$query',
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search recipes');
    }
  }

  Future<List<RecipeDetailsModel>> getRandomRecipes() async {
    final response = await http.get(
      Uri.parse(
        '${AppStrings.baseUrl}/random?apiKey=${AppStrings.apiKey}&number=5',
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['recipes'];
      return results.map((e) => RecipeDetailsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch random recipes');
    }
  }

  Future<List<Recipe>> recipesDetails(String id) async {
    final response = await http.get(
      Uri.parse(
        '${AppStrings.baseUrl}/$id/information?apiKey=${AppStrings.apiKey}',
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // For details, it usually returns a single object. 
      // Wrapping in a list to match the current return type if needed, 
      // but usually detail API returns one object.
      return [RecipeModel.fromJson(json)];
    } else {
      throw Exception('Failed to fetch recipe details');
    }
  }
}