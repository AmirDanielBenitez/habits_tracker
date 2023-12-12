import 'package:flutter/material.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final Function() onTap;
  final Color? color;
  const PrimaryButton(
      {this.text, this.icon, required this.onTap, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? kAccentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadious),
        ),
      ),
      onPressed: onTap,
      child: text != null
          ? Text(
              text!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
          : icon,
    );
  }
}

class DayTimeToggle extends StatelessWidget {
  final DayTimeHabitHome dayTime;
  final Function()? anytimeOnTap;
  final Function()? morningOnTap;
  final Function()? afternoonOnTap;
  final Function()? eveningOnTap;
  const DayTimeToggle(
    this.dayTime, {
    required this.anytimeOnTap,
    required this.morningOnTap,
    required this.afternoonOnTap,
    required this.eveningOnTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration:
          ShapeDecoration(shape: const StadiumBorder(), color: kPrimaryColor),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: anytimeOnTap,
            child: Container(
                color: dayTime == DayTimeHabitHome.anytime
                    ? kAccentColor
                    : Colors.transparent,
                child: Center(child: getDayTime(context, index: 0))),
          )),
          Expanded(
              child: InkWell(
            onTap: morningOnTap,
            child: Container(
                color: dayTime == DayTimeHabitHome.morning
                    ? kAccentColor
                    : Colors.transparent,
                child: Center(child: getDayTime(context, index: 1))),
          )),
          Expanded(
              child: InkWell(
            onTap: afternoonOnTap,
            child: Container(
                color: dayTime == DayTimeHabitHome.afternoon
                    ? kAccentColor
                    : Colors.transparent,
                child: Center(child: getDayTime(context, index: 2))),
          )),
          Expanded(
              child: InkWell(
            onTap: eveningOnTap,
            child: Container(
                color: dayTime == DayTimeHabitHome.evening
                    ? kAccentColor
                    : Colors.transparent,
                child: Center(child: getDayTime(context, index: 3))),
          )),
        ],
      ),
    );
  }
}
