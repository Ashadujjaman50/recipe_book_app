import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_app/presentation/screen/video_player_screen.dart';
import '../provider/recipe_provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  final int recipeId;
  const FoodDetailsScreen({super.key, required this.recipeId});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  bool _isExpanded = false; // Read More কন্ট্রোল করার জন্য

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipeDetails(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.selectedRecipe == null) {
            return const Center(child: Text("Failed to load details"));
          }

          final recipe = provider.selectedRecipe!;
          final cleanDescription = recipe.summary.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

          return Stack(
            children: [
              // Background Image
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recipe.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // AppBar (Back & Bookmark)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text('Recipe Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        child: const Icon(Icons.bookmark_border, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Container
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(recipe.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
                              child: Row(children: const [Icon(Icons.star, color: Colors.orange, size: 16), Text(' 5.0', style: TextStyle(fontWeight: FontWeight.bold))]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text('Description', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        // ডেসক্রিপশন সেকশন
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cleanDescription,
                              maxLines: _isExpanded ? null : 6,
                              overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _isExpanded = !_isExpanded),
                              child: Text(
                                _isExpanded ? "Read Less" : "Read More",
                                style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VideoPlayerScreen(url: 'https://www.youtube.com/watch?v=FIK9KQc5vYc'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                            label: const Text('Watch Videos', style: TextStyle(fontSize: 18, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}