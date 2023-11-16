import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal_model.dart';
import 'package:meals_app/Screens/meal_details_screen.dart';
import 'package:meals_app/Widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals, required this.onToggleFavorites});

  final String? title;
  final List<MealsModel> meals;
  final void Function(MealsModel meal) onToggleFavorites;

  void selectMeal(BuildContext context, MealsModel meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(meal: meal, onToggleFavorites: onToggleFavorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) =>
          MealsItem(meal: meals[index], onSelectMeal: selectMeal),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting the different categories',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
