import 'package:flutter/material.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/resources/icons/app_icons.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/checkList.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';

import '../../widgets/habit_tile.dart';
// import 'package:habits_tracker/assets/icons/app_icons.dart';

class HomeHabits extends StatelessWidget {
  const HomeHabits({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: kPrimaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-habits');
                  },
                  child: const Text(
                    'Create Habit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 25.0,
              icon: const Icon(
                AppIcons.config,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ],
          title: Image.asset(
            'assets/logo/logo_white.png',
            scale: 0.5,
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1), () {
                print('xxx: reload');
              });
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 15.0,
              ),
              padding: const EdgeInsets.only(top: 15),
              itemCount: 10,
              itemBuilder: (context, index) => HabitTile(
                habit: HabitEntity(
                    done: (index % 2 == 0),
                    id: index,
                    name: 'Pray',
                    streak: 10,
                    checkList: const [
                      CheckListEntity(name: 'Pray morning'),
                      CheckListEntity(name: 'Pray evening'),
                    ],
                    dayTime: DayTimeHabit.evening,
                    specificDays: const ['Thu', 'Mon', 'Sat'],
                    color: Colors.amber),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
