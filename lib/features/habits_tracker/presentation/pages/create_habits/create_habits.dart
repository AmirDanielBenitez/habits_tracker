import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/resources/icons/app_icons.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/check_list.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/widgets/buttons.dart';
import 'dart:math' as math;

class CreateHabitsPage extends StatefulWidget {
  const CreateHabitsPage({super.key});

  @override
  State<CreateHabitsPage> createState() => _CreateHabitsPageState();
}

class _CreateHabitsPageState extends State<CreateHabitsPage> {
  String habitName = '';
  late Color habitColor;
  final List<CheckListEntity> checklist = [];
  DayTimeHabit dayTime = DayTimeHabit.anytime;
  final List<Widget> daytimesList = [
    const Text(
      'Anytime',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Morning',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Afternoon',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Evening',
      style: TextStyle(color: Colors.white),
    ),
  ];

  bool repeatsEveryday = true;

  List<String>? specificDays;

  @override
  void initState() {
    super.initState();
    habitColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Habit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        actions: [
          TextButton(
              onPressed: () {
                //#TODO
                //agregar advertencia de campos obligatorios
                final HabitEntity habit = HabitEntity(
                  id: 0,
                  name: habitName,
                  color: habitColor,
                  checkList: checklist,
                  dayTime: dayTime,
                  specificDays: repeatsEveryday ? null : specificDays,
                  done: false,
                  streak: 0,
                );
                print('Habit name: ${habit.name}');
                print('Habit color: ${habit.color}');
                print('Habit checkList: ${habit.checkList}');
                print('Habit dayTime: ${habit.dayTime}');
                print('Habit specificDays: ${habit.specificDays}');
                BlocProvider.of<HabitsBloc>(context)
                    .add(CreateHabitEvent(habit));
                Navigator.pop(context);
              },
              child: const Text(
                'Create',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Habit Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          width: double.infinity,
                          height: 36.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kBorderRadious),
                            color: Colors.white,
                          ),
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                habitName = text;
                              });
                            },
                            cursorColor: kAccentColor,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Color',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        height: 36.0,
                        child: PrimaryButton(
                          icon: Icon(
                            habitColor == null
                                ? Icons.shuffle_rounded
                                : Icons.brush_rounded,
                          ),
                          color: habitColor,
                          onTap: () {
                            _showColorPicker();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                  child: Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Checklist',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 5.0),
                          Visibility(
                            visible: checklist.isNotEmpty,
                            child: SizedBox(
                              height: (checklist.length + 1) * 41.0,
                              child: checkListView(),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              text: 'New checklist item',
                              onTap: () {
                                final int newIndex = checklist.length + 1;

                                setState(() {
                                  checklist.add(CheckListEntity(
                                      name:
                                          '${getIndexText(newIndex)} checklist'));
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Daytime',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            height: 36.0,
                            decoration: ShapeDecoration(
                                shape: const StadiumBorder(),
                                color: kBackgroundColor),
                            clipBehavior: Clip.antiAlias,
                            child: Row(
                              children: getDayTimeToggles,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Repeats',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 5.0),
                          SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                  onTap: () {
                                    setState(() {
                                      repeatsEveryday = !repeatsEveryday;
                                    });
                                  },
                                  text: repeatsEveryday
                                      ? 'Everyday'
                                      : 'Custom days')),
                          const SizedBox(height: 5.0),
                          Visibility(
                            visible: !repeatsEveryday,
                            child: SelectWeekDays(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              days: kDaysInWeek,
                              border: false,
                              boxDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadious),
                                  color: kBackgroundColor),
                              daysFillColor: kAccentColor,
                              selectedDayTextColor: Colors.white,
                              unSelectedDayTextColor: Colors.white,
                              onSelect: (values) {
                                specificDays = values;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get getDayTimeToggles {
    return [
      Expanded(
          child: InkWell(
        onTap: () => setState(() {
          dayTime = DayTimeHabit.anytime;
        }),
        child: Container(
            color: dayTime == DayTimeHabit.anytime
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: daytimesList[0])),
      )),
      Expanded(
          child: InkWell(
        onTap: () => setState(() {
          dayTime = DayTimeHabit.morning;
        }),
        child: Container(
            color: dayTime == DayTimeHabit.morning
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: daytimesList[1])),
      )),
      Expanded(
          child: InkWell(
        onTap: () => setState(() {
          dayTime = DayTimeHabit.afternoon;
        }),
        child: Container(
            color: dayTime == DayTimeHabit.afternoon
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: daytimesList[2])),
      )),
      Expanded(
          child: InkWell(
        onTap: () => setState(() {
          dayTime = DayTimeHabit.evening;
        }),
        child: Container(
            color: dayTime == DayTimeHabit.evening
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: daytimesList[3])),
      )),
    ];
  }

  ReorderableListView checkListView() {
    return ReorderableListView(
      children: [
        for (int i = 0; i < checklist.length; i++)
          Container(
            key: ValueKey('$i${checklist[i].hashCode}'),
            height: 36.0,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadious),
              color: kBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: const EdgeInsets.only(left: 10.0),
                    onPressed: () {
                      setState(() {
                        checklist.removeAt(i);
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.white,
                    )),
                Expanded(
                    child: TextField(
                  onChanged: (text) {
                    checklist[i] = CheckListEntity(name: text);
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: kAccentColor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: checklist[i].name,
                      hintStyle: const TextStyle(color: Colors.white)),
                )),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    AppIcons.sort,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          )
      ],
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex--;
          }

          final checkItem = checklist.removeAt(oldIndex);
          checklist.insert(newIndex, checkItem);
        });
      },
    );
  }

  String getIndexText(int index) {
    if (index < 0) {
      return '';
    }
    int unidad = index % 10;
    if (unidad == 1) {
      return "$index-st";
    } else if (unidad == 2) {
      return "$index-nd";
    } else if (unidad == 3) {
      return "$index-rd";
    } else {
      return "$index-th";
    }
  }

  void _showColorPicker() {
    setState(() {
      habitColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });

    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          //definir
          // child: BlockPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: (color) {
          //     setState(() {
          //       habitColor = color;
          //     });
          //   },
          // ),
          child: ColorPicker(
            pickerColor: habitColor,
            paletteType: PaletteType.hueWheel,
            onColorChanged: (color) {
              setState(() {
                habitColor = color;
              });
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }
}
