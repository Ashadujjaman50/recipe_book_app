import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_app/presentation/provider/random_recipe_provider.dart';
import 'package:recipe_book_app/presentation/provider/recipe_provider.dart';
import 'presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => RandomRecipeProvider()),
      ],
      child: MaterialApp(
        title: 'Recipe Book App',
        theme: ThemeData(
          // This is the theme of your application.
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}