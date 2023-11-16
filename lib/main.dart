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

  // await database.into(database.habitItems).insert(HabitItemsCompanion.insert(
  //       name: 'Pray',
  //       color: Colors.red.value,
  //       // streak: Value(0),
  //       checkList: const Value([
  //         CheckListModel(name: 'Pray Morning', done: false),
  //         CheckListModel(name: 'Pray Night', done: false),
  //       ]),
  //       dayTime: const Value(DayTimeHabit.evening),
  //       specificDays: const Value('["mon","fri"]'),
  //     ));
  // List<HabitItem> allItems = await database.select(database.habitItems).get();
  // print('items in database: $allItems');
  // HabitEntity habit = HabitModel.fromItem(allItems.first);

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
