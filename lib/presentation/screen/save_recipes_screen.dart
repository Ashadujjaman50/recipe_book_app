import 'package:flutter/material.dart';
import 'food_details_screen.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: IconButton(
                  icon: Image.network('https://img.lightshot.app/cUeGAJUNTr2_hmMVt_vCbQ.png', width: 20),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
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
                  _buildSavedRecipeItem(
                    context,
                    "Pancake",
                    "4.5",
                    "Kadin Curtis",
                    'https://img.lightshot.app/y2v_pm1xR5uiIz099TKwIA.png',
                  ),
                  _buildSavedRecipeItem(
                    context,
                    "Oyster Dish",
                    "4.3",
                    "Terry Carder",
                    'https://img.lightshot.app/ESesIcT8S82HFFY6oSYSVw.png',
                  ),
                  _buildSavedRecipeItem(
                    context,
                    "Fried Rice",
                    "4.8",
                    "Carter Carder",
                    'https://img.lightshot.app/vYPAQEhATfa0yQ82AuC_dA.png',
                  ),
                  _buildSavedRecipeItem(
                    context,
                    "Greek Quinoa Salad",
                    "3.9",
                    "Carter Carder",
                    'https://img.lightshot.app/QxCpEw-YSSyb-c4NJIdV0w.png',
                  ),
                  _buildSavedRecipeItem(
                    context,
                    "Classic Fluffy",
                    "3.8",
                    "Desirae Herwitz",
                    'https://img.lightshot.app/mFKUgv0RRQaB_4-4grCr1Q.png',
                  ),
                  _buildSavedRecipeItem(
                    context,
                    "Cacao Maca Walnut",
                    "3.7",
                    "Kadin Curtis",
                    'https://img.lightshot.app/z6H5Kx8CQX6-tmU-kTI_IA.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildSavedRecipeItem(BuildContext context, String title, String rating, String author, String imgUrl) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FoodDetailsScreen()),
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
