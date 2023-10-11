
import 'package:flutter/material.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/home_habits/home_habits.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomeHabits());
      default:
        return _materialRoute(const HomeHabits());
    }
  }
   static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}