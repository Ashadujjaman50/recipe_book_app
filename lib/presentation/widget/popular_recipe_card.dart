import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/recipe_provider.dart';
import '../../data/model/recipe_model.dart';
import '../screen/food_details_screen.dart';

class PopularRecipeCard extends StatelessWidget {
  const PopularRecipeCard({
    super.key,
    required this.id,
    required this.context,
    required this.title,
    required this.author,
    required this.rating,
    required this.imgUrl,
  });

  final int id;
  final BuildContext context;
  final String title;
  final String author;
  final String rating;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, provider, child) {
        final isSaved = provider.isRecipeSaved(id);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodDetailsScreen(recipeId: id)),
            );
          },
          child: Container(
            width: 200,
            margin: const EdgeInsets.only(right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(imgUrl, height: 180, width: 200, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 10, left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withAlpha(100), borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [const Icon(Icons.star, color: Colors.amber, size: 14), Text(" $rating", style: const TextStyle(color: Colors.white))]),
                      ),
                    ),
                    // Save Recipe Button
                    Positioned(
                      top: 10, right: 10,
                      child: GestureDetector(
                        onTap: () {
                          provider.toggleSaveRecipe(
                            RecipeModel(id: id, title: title, image: imgUrl),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            'https://img.lightshot.app/sgYyX5kwTsqM623JXgAAaQ.png',
                            width: 24,
                            height: 24,
                            color: isSaved ? Colors.deepOrange : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("By: $author", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
