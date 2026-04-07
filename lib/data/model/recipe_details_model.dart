import '../../domain/entities/recipe_details_entities.dart';

class RecipeDetailsModel extends RecipeDetails {
  RecipeDetailsModel({required super.id, required super.title, required super.image, required super.summary});

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'image': image, 'summary': summary};
  }
}