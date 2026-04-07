import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({required super.id, required super.title, required super.image, required super.summary});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
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