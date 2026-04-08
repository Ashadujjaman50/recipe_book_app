import 'package:flutter/material.dart';

import '../screen/food_details_screen.dart';

class WeeklyRecipeCard extends StatelessWidget {
  const WeeklyRecipeCard({
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetailsScreen(recipeId: id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imgUrl, height: 80, width: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(children: [const Icon(Icons.star, color: Colors.amber, size: 16), Text(" $rating", style: const TextStyle(color: Colors.grey))]),
                  Text("By: $author", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Image.network('https://img.lightshot.app/sgYyX5kwTsqM623JXgAAaQ.png', width: 24, height: 24, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
