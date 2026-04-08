import 'recipe_entities.dart';

class RecipeDetails extends Recipe {
  final String summary;

  RecipeDetails({
    required super.id,
    required super.title,
    required super.image,
    required this.summary,
  });
}
