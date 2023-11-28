import 'package:flutter/material.dart';
import 'package:habits_tracker/features/config_page/presentation/pages/config_page/config_page.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/create_habits/create_habits.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/edit_habits/edit_habits.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/home_habits/home_habits.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeHabits());
      case '/create-habits':
        return _materialRoute(const CreateHabitsPage());
      case '/edit-habits':
        return _materialRoute(EditHabitsPage(
          habit: settings.arguments as HabitEntity,
        ));
      case '/config-page':
        return _materialRoute(const ConfigPage());
      default:
        return _materialRoute(const HomeHabits());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
