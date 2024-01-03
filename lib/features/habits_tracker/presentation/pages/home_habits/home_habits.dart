import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/resources/helper.dart';
import 'package:habits_tracker/core/resources/icons/app_icons.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/widgets/buttons.dart';

import '../../widgets/habit_tile.dart';

class HomeHabits extends StatefulWidget with WidgetsBindingObserver {
  const HomeHabits({super.key});

  @override
  State<HomeHabits> createState() => _HomeHabitsState();
}

class _HomeHabitsState extends State<HomeHabits> {
  DayTimeHabitHome dayTime = DayTimeHabitHome.all;

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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: PrimaryButton(
              onTap: () {
                Navigator.pushNamed(context, '/create-habits');
              },
              text: ln(context).createHabit,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/config-page');
            },
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
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(99)),
                                    onTap: () {
                                      setState(() {
                                        dayTime = DayTimeHabitHome.all;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                dayTime == DayTimeHabitHome.all
                                                    ? kAccentColor
                                                    : kPrimaryColor,
                                          ),
                                          child: Center(
                                              child: Text(
                                            ln(context).all,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ))),
                                    ),
                                  ),
                                  Expanded(
                                    child: DayTimeToggle(
                                      dayTime,
                                      anytimeOnTap: () {
                                        setState(() {
                                          dayTime = DayTimeHabitHome.anytime;
                                        });
                                      },
                                      morningOnTap: () {
                                        setState(() {
                                          dayTime = DayTimeHabitHome.morning;
                                        });
                                      },
                                      afternoonOnTap: () {
                                        setState(() {
                                          dayTime = DayTimeHabitHome.afternoon;
                                        });
                                      },
                                      eveningOnTap: () {
                                        setState(() {
                                          dayTime = DayTimeHabitHome.evening;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: HabitsList(
                                state.habits
                                    .where((element) => dayTime.name != 'all'
                                        ? (element.dayTime.name == dayTime.name)
                                        : true)
                                    .toList(),
                              ),
                            ),
                          ],
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
                              Text(
                                ln(context).habitsnotyetcreated,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
    );
  }
}

class HabitsList extends StatelessWidget {
  final List<HabitEntity> habits;
  const HabitsList(
    this.habits, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final HabitEntity habit = habits[index];

        if (habit.specificDays != null) {
          final String day = kDaysInWeek[DateTime.now().weekday - 1].dayName;
          if (!habit.specificDays!.contains(day)) {
            return Container();
          }
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: HabitTile(habit: habit),
        );
      },
    );
  }
}
