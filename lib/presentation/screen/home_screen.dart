import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_strings.dart';
import '../provider/recipe_provider.dart';
import '../provider/random_recipe_provider.dart';
import '../screen/search_screen.dart';
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
    super.initState();
    // স্ক্রিন লোড হওয়ার সাথে সাথে দুটি API কল করা হচ্ছে
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipesByCategory(_selectedCategory);
      context.read<RandomRecipeProvider>().fetchRandomRecipes();
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
          _buildActionButton('https://img.lightshot.app/cUeGAJUNTr2_hmMVt_vCbQ.png', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
          }),
          const SizedBox(width: 10),
          _buildActionButton('https://img.lightshot.app/XteT11nvRv-S5j1IisHOXg.png', () {}),
          const SizedBox(width: 16),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<RecipeProvider>().fetchRecipesByCategory(_selectedCategory);
          context.read<RandomRecipeProvider>().fetchRandomRecipes();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
              _buildPopularRecipesSection(),
              const SizedBox(height: 25),
              const Text("Recipes of The Week", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildWeeklyRecipesSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildActionButton(String iconUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Image.network(iconUrl, width: 24, height: 24),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedCategory = category);
                context.read<RecipeProvider>().fetchRecipesByCategory(category);
              },
              child: CategoryItemWidget(title: category, isSelected: category == _selectedCategory),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularRecipesSection() {
    return SizedBox(
      height: 260,
      child: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          // এখানে isLoading এর বদলে isCategoryLoading হবে
          if (provider.isCategoryLoading && provider.categoryRecipes.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.categoryRecipes.isEmpty) {
            return Center(child: Text('No recipes found.'));
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
        },
      ),
    );
  }

  Widget _buildWeeklyRecipesSection() {
    return Consumer<RandomRecipeProvider>(
      builder: (context, provider, child) {
        if (provider.isWeeklyLoading && provider.weeklyRecipes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.weeklyRecipes.isEmpty) {
          return const Center(child: Text('No weekly recipes found.'));
        }
        return Column(
          children: provider.weeklyRecipes.map((recipe) {
            return WeeklyRecipeCard(
              context: context,
              title: recipe.title,
              author: "Terry Carder",
              rating: "4.5",
              imgUrl: recipe.image,
            );
          }).toList(),
        );
      },
    );
  }
}