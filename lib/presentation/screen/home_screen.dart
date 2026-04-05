import 'package:flutter/material.dart';
import 'food_details_screen.dart';
import '../widget/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1780&auto=format&fit=crop'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Welcome Back!", style: TextStyle(color: Colors.grey, fontSize: 14)),
            Text("Omar Calzoni", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                icon: Image.network('https://img.lightshot.app/cUeGAJUNTr2_hmMVt_vCbQ.png', width: 24, height: 24),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(width: 10,),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                icon: Image.network('https://img.lightshot.app/XteT11nvRv-S5j1IisHOXg.png', width: 24, height: 24),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(width: 10,),

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryItem("All", true),
                _buildCategoryItem("Breakfast", false),
                _buildCategoryItem("Lunch", false),
                _buildCategoryItem("Dinner", false),
              ],
            ),
            const SizedBox(height: 25),
            const Text("Popular Recipes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SizedBox(
              height: 280,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPopularCard(context, "Seafood Fried Rice", "Kadin Curtis", "5.0", 'https://img.lightshot.app/ESesIcT8S82HFFY6oSYSVw.png'),
                  _buildPopularCard(context, "Caprese Salad", "Desirae Herwitz", "4.9", 'https://img.lightshot.app/QxCpEw-YSSyb-c4NJIdV0w.png'),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text("Recipes of The Weeks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildWeeklyCard(context, "Pancake", "Terry Carder", "4.5", 'https://img.lightshot.app/y2v_pm1xR5uiIz099TKwIA.png'),
            _buildWeeklyCard(context, "Chicken Alfredo", "Carter Carder", "4.0", 'https://img.lightshot.app/z6H5Kx8CQX6-tmU-kTI_IA.png'),
            _buildWeeklyCard(context, "Fried Rice", "Kadin Curtis", "4.8", 'https://img.lightshot.app/mFKUgv0RRQaB_4-4grCr1Q.png'),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildCategoryItem(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepOrange : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
      ),
      child: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPopularCard(BuildContext context, String title, String author, String rating, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FoodDetailsScreen()),
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
                  child: Image.network(imgUrl, height: 200, width: 200, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10, left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [const Icon(Icons.star, color: Colors.amber, size: 14), Text(" $rating", style: const TextStyle(color: Colors.white))]),
                  ),
                ),
                Positioned(
                  top: 10, right: 10,
                  child: Image.network('https://img.lightshot.app/sgYyX5kwTsqM623JXgAAaQ.png', width: 24, height: 24),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text("By: $author", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyCard(BuildContext context, String title, String author, String rating, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FoodDetailsScreen()),
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
            Image.network('https://img.lightshot.app/sgYyX5kwTsqM623JXgAAaQ.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}
