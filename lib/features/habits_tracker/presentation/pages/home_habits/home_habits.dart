import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/resources/helper.dart';
import 'package:habits_tracker/core/resources/icons/app_icons.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';

import '../../widgets/habit_tile.dart';

class HomeHabits extends StatefulWidget with WidgetsBindingObserver {
  const HomeHabits({super.key});

  @override
  State<HomeHabits> createState() => _HomeHabitsState();
}

class _HomeHabitsState extends State<HomeHabits> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
        resumeCallBack: () async => setState(() {
              BlocProvider.of<HabitsBloc>(context).add(LoadHabitsEvent());
            })));
  }

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
          child: BlocBuilder<HabitsBloc, HabitsState>(
            builder: (context, state) {
              if (state is HabitsLoading) {
                return Center(
                    child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: CupertinoActivityIndicator(
                    color: kAccentColor,
                  ),
                ));
              }
              if (state is HabitsLoaded) {
                return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1), () {});
                    },
                    child: state.habits.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15.0,
                            ),
                            padding: const EdgeInsets.only(top: 15),
                            itemCount: state.habits.length,
                            itemBuilder: (context, index) {
                              return HabitTile(habit: state.habits[index]);
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.create,
                                  color: kAccentColor,
                                  size: 100,
                                ),
                                const Text(
                                  'No hay habitos creados ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0),
                                ),
                              ],
                            ),
                          ));
              }
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 100,
                    ),
                    Text(
                      'Lo sentimos los habitos no pudierons ser cargados',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
