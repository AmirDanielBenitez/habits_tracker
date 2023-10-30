import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';

Color kBackgroundColor = const Color(0xff6527BE);
Color kPrimaryColor = const Color(0xff9681EB);
Color kAccentColor = const Color(0xff45CFDD);
const double kBorderRadious = 4.0;

final List<DayInWeek> kDaysInWeek = [
  DayInWeek(
    "Mon",
    dayKey: 'Mon',
  ),
  DayInWeek("Tue", dayKey: 'Tue'),
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
