import 'package:flutter/material.dart';
import '../widget/save_recipe_card.dart';
import 'home_screen.dart';
import '../widget/bottom_navigation_bar.dart';

class SavedRecipesScreen extends StatelessWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => const HomeScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ),
        ),
        title: const Text(
          "Saved Recipes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Toggle Switch
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          "Untried",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child: Text(
                          "Made it",
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Recipe List
            Expanded(
              child: ListView(
                children: [
                  SaveRecipeItem(context: context, title: "Pancake", rating: "4.5", author: "Kadin Curtis", imgUrl: 'https://img.lightshot.app/y2v_pm1xR5uiIz099TKwIA.png'),
                  SaveRecipeItem(context: context, title: "Oyster Dish", rating: "4.3", author: "Terry Carder", imgUrl: 'https://img.lightshot.app/ESesIcT8S82HFFY6oSYSVw.png'),
                  SaveRecipeItem(context: context, title: "Fried Rice", rating: "4.8", author: "Carter Carder", imgUrl: 'https://img.lightshot.app/vYPAQEhATfa0yQ82AuC_dA.png'),
                  SaveRecipeItem(context: context, title: "Greek Quinoa Salad", rating: "3.9", author: "Carter Carder", imgUrl: 'https://img.lightshot.app/QxCpEw-YSSyb-c4NJIdV0w.png'),
                  SaveRecipeItem(context: context, title: "Classic Fluffy", rating: "3.8", author: "Desirae Herwitz", imgUrl: 'https://img.lightshot.app/mFKUgv0RRQaB_4-4grCr1Q.png'),
                  SaveRecipeItem(context: context, title: "Cacao Maca Walnut", rating: "3.7", author: "Kadin Curtis", imgUrl: 'https://img.lightshot.app/z6H5Kx8CQX6-tmU-kTI_IA.png'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}

