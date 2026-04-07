import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_strings.dart';
import '../provider/recipe_provider.dart';
import '../widget/search_recipe_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // টাইপ করার সাথে সাথে এই ফাংশনটি কল হবে
  void _onSearch(String value) {
    final query = value.trim();
    if (query.isNotEmpty) {
      context.read<RecipeProvider>().searchRecipes(query);
    } else {
      // যদি টেক্সট বক্স খালি হয়, তবে রেজাল্ট ক্লিয়ার করে দেবে
      context.read<RecipeProvider>().clearSearchResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: const InputDecoration(
            hintText: AppStrings.searchHint,
            border: InputBorder.none,
          ),
          // এখানে onChanged যোগ করা হয়েছে
          onChanged: _onSearch,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: AppColors.textSecondary),
            onPressed: () {
              _searchController.clear();
              context.read<RecipeProvider>().clearSearchResults();
            },
          ),
        ],
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (provider.searchResults.isEmpty && _searchController.text.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.typeToSearch,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          if (provider.searchResults.isEmpty && _searchController.text.isNotEmpty) {
            return const Center(
              child: Text(
                AppStrings.noRecipesFound,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              return SearchRecipeCard(recipe: provider.searchResults[index]);
            },
          );
        },
      ),
    );
  }
}