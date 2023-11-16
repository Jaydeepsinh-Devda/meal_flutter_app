import 'package:flutter/material.dart';
import 'package:meals_app/Data/dummy_data.dart';
import 'package:meals_app/Models/category_model.dart';
import 'package:meals_app/Screens/meals_screen.dart';
import 'package:meals_app/Widgets/category_grid_item.dart';

import '../Models/meal_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.onToggleFavorites});

  final void Function(MealsModel meal) onToggleFavorites;


  void _selectCategory(BuildContext context, CategoryModel category) {
    final filteredMeals =
        dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorites: onToggleFavorites,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
                categoryModel: category,
                onSelectCategory: () {
                  _selectCategory(context,category);
                })
        ],
    );
  }
}
