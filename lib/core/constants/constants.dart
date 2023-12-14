import 'package:auto_size_text/auto_size_text.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/core/resources/helper.dart';

Color kBackgroundColor = const Color(0xff6527BE);
Color kPrimaryColor = const Color(0xff9681EB);
Color kAccentColor = const Color(0xff45CFDD);
const double kBorderRadious = 4.0;

final List<DayInWeek> kDaysInWeek = [
  DayInWeek(
    "Mon",
    dayKey: 'Mon',
  ),
  DayInWeek(
    "Tue",
    dayKey: 'Tue',
  ),
  DayInWeek(
    "Wed",
    dayKey: 'Wed',
  ),
  DayInWeek(
    "Thu",
    dayKey: 'Thu',
  ),
  DayInWeek(
    "Fri",
    dayKey: 'Fri',
  ),
  DayInWeek(
    "Sat",
    dayKey: 'Sat',
  ),
  DayInWeek(
    "Sun",
    dayKey: 'Sun',
  ),
];

final List<DayInWeek> kDaysInWeekES = [
  DayInWeek(
    "Lun",
    dayKey: 'Mon',
  ),
  DayInWeek(
    "Mar",
    dayKey: 'Tue',
  ),
  DayInWeek(
    "Mie",
    dayKey: 'Wed',
  ),
  DayInWeek(
    "Jue",
    dayKey: 'Thu',
  ),
  DayInWeek(
    "Vie",
    dayKey: 'Fri',
  ),
  DayInWeek(
    "Sab",
    dayKey: 'Sat',
  ),
  DayInWeek(
    "Dom",
    dayKey: 'Sun',
  ),
];

Widget getDayTime(BuildContext context, {required int index}) {
  List<Widget> daytimesList = [
    Text(
      ln(context).anytime,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
    Text(
      ln(context).morning,
      style: const TextStyle(color: Colors.white),
    ),
    Text(
      ln(context).afternoon,
      style: const TextStyle(color: Colors.white),
    ),
    Text(
      ln(context).evening,
      style: const TextStyle(color: Colors.white),
    ),
  ];

  return daytimesList[index];
}
