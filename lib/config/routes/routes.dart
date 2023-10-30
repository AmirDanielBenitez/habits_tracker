import 'package:flutter/material.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/create_habits/create_habits.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/home_habits/home_habits.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeHabits());
      case '/create-habits':
        return _materialRoute(const CreateHabitsPage());
      default:
        return _materialRoute(const HomeHabits());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
