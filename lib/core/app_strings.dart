
class AppStrings {
  static const String appName = 'Recipe App';

  // API Constants
  static const String apiKey = 'eed6988d281a448e9d2b00c1a0eb6f41';

  // UI Strings
  static const String categories = 'Categories';
  static const String searchRecipes = 'Search Recipes';
  static const String favorites = 'Favorites';
  static const String ingredients = 'Ingredients';
  static const String instructions = 'Instructions';
  static const String noRecipesFound = 'No recipes found.';
  static const String noFavoritesYet = 'No favorite recipes yet.';
  static const String noInstructions =
      'Instructions not available for this recipe.';
  static const String searchHint = 'Search for pasta, chicken...';

  // Newly Added UI Strings
  static const String welcomeBack = 'Welcome Back ';
  static const String letsCook = 'Let\'s Cook!';
  static const String recipeDetails = 'Recipe Details';
  static const String failedToLoadRecipe = 'Failed to load recipe details.';
  static const String typeToSearch = 'Type to search for recipes.';
  static const String defaultRating = '5.0';
  static const String mins = ' mins';
  static const String servings = ' servings';

  // Constants
  static const List<String> recipeCategories = [
    'Italian',
    'Mexican',
    'Asian',
    'American',
    'Indian',
  ];

  static const String baseUrl = 'https://api.spoonacular.com/recipes';
  static const String profileImageUrl =
      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1780&auto=format&fit=crop';
}
