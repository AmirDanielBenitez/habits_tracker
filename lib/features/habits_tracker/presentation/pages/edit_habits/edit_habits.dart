import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/core/resources/helper.dart';
import 'package:habits_tracker/core/resources/icons/app_icons.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/check_list.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/widgets/buttons.dart';
import 'dart:math' as math;

import 'package:reorderables/reorderables.dart';

class EditHabitsPage extends StatefulWidget {
  final HabitEntity habit;
  const EditHabitsPage({required this.habit, super.key});

  @override
  State<EditHabitsPage> createState() => _EditHabitsPageState();
}

class _EditHabitsPageState extends State<EditHabitsPage> {
  late TextEditingController habitNameController;
  late Color habitColor;
  List<CheckListEntity> checklist = [];
  final List<FocusNode> _focusNodes = [];
  DayTimeHabit dayTime = DayTimeHabit.anytime;

  bool repeatsEveryday = true;

  List<String>? specificDays;

  List<DayInWeek> daysInWeek = kDaysInWeek;

  @override
  void initState() {
    super.initState();
    habitNameController = TextEditingController(text: widget.habit.name);
    habitColor = widget.habit.color;
    checklist = [...?widget.habit.checkList];
    dayTime = widget.habit.dayTime;
    repeatsEveryday = widget.habit.specificDays == null;
    if (widget.habit.specificDays?.isNotEmpty ?? false) {
      for (String specificDay in widget.habit.specificDays!) {
        daysInWeek.firstWhere((day) => day.dayName == specificDay).isSelected =
            true;
      }
    }
  }

  @override
  void dispose() {
    specificDays = null;
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.habit.name,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                final HabitEntity habit = widget.habit.copyWith(
                    name: habitNameController.text,
                    color: habitColor,
                    checkList: checklist,
                    dayTime: dayTime,
                    specificDays: repeatsEveryday ? null : specificDays,
                    done: widget.habit.done,
                    streak: widget.habit.streak);

                BlocProvider.of<HabitsBloc>(context).add(EditHabitEvent(habit));
                Navigator.pop(context);

                print('Habit name: ${habit.name}');
                print('Habit color: ${habit.color}');
                print('Habit checkList: ${habit.checkList}');
                print('Habit dayTime: ${habit.dayTime}');
                print('Habit specificDays: ${habit.specificDays}');
              },
              child: Text(
                ln(context).save,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          BlocProvider.of<HabitsBloc>(context)
              .add(DeleteHabitEvent(widget.habit.id));
          Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.delete_forever_rounded,
        ),
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
                        Text(
                          ln(context).habitName,
                          style: const TextStyle(color: Colors.white),
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
                                habitNameController.text = text;
                              });
                            },
                            controller: habitNameController,
                            cursorColor: kAccentColor,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                bottom: 36 / 2,
                              ),
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
                            ln(context).checklist(0),
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 5.0),
                          Visibility(
                            visible: checklist.isNotEmpty,
                            child: SizedBox(
                              height: (checklist.length + 1) * 41.0,
                              child: checkList(),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              text: ln(context).newCheckListItem,
                              onTap: () {
                                final int newIndex = checklist.length + 1;

                                setState(() {
                                  checklist.add(CheckListEntity(
                                      name:
                                          '${getIndexText(newIndex)} ${ln(context).checklist(1)}'));
                                });
                                _focusNodes.add(FocusNode());
                                _focusNodes[newIndex - 1].requestFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            ln(context).daytime,
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
                            ln(context).repeats,
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
                                    ? ln(context).everyday
                                    : ln(context).customDays,
                              )),
                          const SizedBox(height: 5.0),
                          Visibility(
                            visible: !repeatsEveryday,
                            child: SelectWeekDays(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              days: Localizations.localeOf(context)
                                          .languageCode ==
                                      'en'
                                  ? kDaysInWeek
                                  : kDaysInWeekES,
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(99), bottomLeft: Radius.circular(99)),
          onTap: () => setState(() {
            dayTime = DayTimeHabit.anytime;
          }),
          child: Container(
            color: dayTime == DayTimeHabit.anytime
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: getDayTime(context, index: 0)),
          ),
        ),
      ),
      Expanded(
          child: InkWell(
        onTap: () => setState(() {
          dayTime = DayTimeHabit.morning;
        }),
        child: Container(
            color: dayTime == DayTimeHabit.morning
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: getDayTime(context, index: 1))),
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
            child: Center(child: getDayTime(context, index: 2))),
      )),
      Expanded(
          child: InkWell(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(99), bottomRight: Radius.circular(99)),
        onTap: () => setState(() {
          dayTime = DayTimeHabit.evening;
        }),
        child: Container(
            color: dayTime == DayTimeHabit.evening
                ? kAccentColor
                : Colors.transparent,
            child: Center(child: getDayTime(context, index: 3))),
      )),
    ];
  }

  Widget checkList() {
    return ReorderableWrap(
      scrollPhysics: const NeverScrollableScrollPhysics(),
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
                    child: Center(
                  child: TextField(
                    focusNode: _focusNodes.isNotEmpty ? _focusNodes[i] : null,
                    onChanged: (text) {
                      checklist[i] = CheckListEntity(name: text);
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: kAccentColor,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          bottom: 36 / 3,
                        ),
                        border: InputBorder.none,
                        hintText: checklist[i].name,
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
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
          ),
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
        title: Text(ln(context).pickacolor),
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
            child: Text(ln(context).gotit),
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
