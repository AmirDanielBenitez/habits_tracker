import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/config/routes/routes.dart';
import 'package:habits_tracker/config/theme/app_themes.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/home_habits/home_habits.dart';

import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitsBloc>(
          create: (context) => sl()..add(LoadHabitsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const HomeHabits(),
      ),
    );
  }
}
