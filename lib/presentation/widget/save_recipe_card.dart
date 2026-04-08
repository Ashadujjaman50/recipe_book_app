import 'package:flutter/material.dart';

import '../screen/food_details_screen.dart';

class SaveRecipeItem extends StatelessWidget {
  const SaveRecipeItem({
    super.key,
    required this.id,
    required this.context,
    required this.title,
    required this.rating,
    required this.author,
    required this.imgUrl,
  });

  final int id;
  final BuildContext context;
  final String title;
  final String rating;
  final String author;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetailsScreen(recipeId: id)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imgUrl, height: 100, width: 100, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(rating, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "By: $author",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Image.network(
              'https://img.lightshot.app/sgYyX5kwTsqM623JXgAAaQ.png',
              width: 24,
              height: 24,
              color: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}