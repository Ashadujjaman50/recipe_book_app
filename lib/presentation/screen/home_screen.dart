import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_app/presentation/screen/search_screen.dart';
import '../../core/app_strings.dart';
import '../provider/recipe_provider.dart';
import '../widget/category_item_card.dart';
import '../widget/popular_recipe_card.dart';
import '../widget/weekly_recipe_card.dart';
import '../widget/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = [
    'All',
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'French',
    'Thai',
  ];

  String _selectedCategory = 'All';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipesByCategory(_selectedCategory);
    });
  }

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
            backgroundImage: NetworkImage(AppStrings.profileImageUrl),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(AppStrings.welcomeBack, style: TextStyle(color: Colors.grey, fontSize: 14)),
            Text("Ashadujjaman", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
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
            const SizedBox(height: 10),

            _buildCategoryList(),

            const SizedBox(height: 25),
            const Text("Popular Recipes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            SizedBox(
              height: 260,
              child: Consumer<RecipeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.categoryRecipes.isEmpty) {
                    return Center(
                      child: Text('No recipes found for this category.'),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.categoryRecipes.length,
                      itemBuilder: (context, index) {
                        return PopularRecipeCard(
                          context: context, title: provider.categoryRecipes[index].title, author: "Kadin Curtis", rating: "5.0", imgUrl: provider.categoryRecipes[index].image,
                        );
                      },
                  );
                }

              ),
            ),

            const SizedBox(height: 25),
            const Text("Recipes of The Weeks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            WeeklyRecipeCard(context: context, title: "Pancake", author: "Terry Carder", rating: "4.5", imgUrl: 'https://img.lightshot.app/y2v_pm1xR5uiIz099TKwIA.png'),
            WeeklyRecipeCard(context: context, title: "Chicken Alfredo", author: "Carter Carder", rating: "4.0", imgUrl: 'https://img.lightshot.app/z6H5Kx8CQX6-tmU-kTI_IA.png'),
            WeeklyRecipeCard(context: context, title: "Fried Rice", author: "Kadin Curtis", rating: "4.8", imgUrl: 'https://img.lightshot.app/mFKUgv0RRQaB_4-4grCr1Q.png'),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                if (_selectedCategory == category) return;

                setState(() {
                  _selectedCategory = category;
                });

                context.read<RecipeProvider>().fetchRecipesByCategory(category);
              },
              child: CategoryItemWidget(title: category, isSelected: isSelected),
            ),
          );
        },
      ),
    );
  }
}





