import 'package:flutter/material.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://img.lightshot.app/ESesIcT8S82HFFY6oSYSVw.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Back and Bookmark Buttons
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
                  const Text(
                    'Recipe Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Seafood Fried Rice',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Text(' 5.0', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoItem(Icons.access_time, '20 mins'),
                        _buildInfoItem(Icons.bar_chart, 'Medium'),
                        _buildInfoItem(Icons.local_fire_department, '100 Cal'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage('https://img.lightshot.app/OnTl2GlQSwqp4Pr_hv0UJA.png'),
                        ),
                        SizedBox(width: 10),
                        Text('Kadin Curtis', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIngredientItem('White rice', '1 Pet', 'https://img.lightshot.app/-y8n09l-SRqrSHcm8q7UsA.png'),
                        _buildIngredientItem('Shrimp', '5 Seeds', 'https://img.lightshot.app/Wg1iNL64S8-a1Ig0mnbIQA.png'),
                        _buildIngredientItem('Squid', '3 Seeds', 'https://img.lightshot.app/oXhfSiFeSQK7xP7BVUJzww.png'),
                        _buildIngredientItem('Soy Sauce', 'Enough', 'https://img.lightshot.app/FWc4Ay7SRXWN6c98DCGswA.png'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
                        children: [
                          const TextSpan(
                            text: 'Enjoy the tantalizing flavors of our Seafood Fried Rice a savory blend of fragrant rice, succulent shrimp, tender squid, and delectable clams.....',
                          ),
                          TextSpan(
                            text: 'Read More',
                            style: TextStyle(color: Colors.deepOrange.shade400, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {},
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
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildIngredientItem(String name, String qty, String imageUrl) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(qty, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}
