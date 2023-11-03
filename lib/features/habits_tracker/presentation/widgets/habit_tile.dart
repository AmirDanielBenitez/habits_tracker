import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/check_list.dart';
import 'package:habits_tracker/features/habits_tracker/domain/entities/habit.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../../../core/constants/constants.dart';

class HabitTile extends StatefulWidget {
  final HabitEntity habit;
  const HabitTile({
    super.key,
    required this.habit,
  });

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  bool showChecklist = false;
  late bool done;

  @override
  void initState() {
    super.initState();
    done = widget.habit.done;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: kAccentColor,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(Icons.edit, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.edit, color: Colors.white),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) {
        Navigator.pushNamed(context, '/edit-habits', arguments: widget.habit);
        return Future(() => false);
      },
      key: Key(widget.habit.id.toString()),
      child: InkWell(
        splashColor: kAccentColor,
        onTap: () {
          if (widget.habit.checkList?.isNotEmpty ?? false) {
            setState(() {
              showChecklist = !showChecklist;
            });
          }
        },
        onLongPress: () {
          HapticFeedback.vibrate();
          setState(() {
            done = !done;
          });
        },
        child: Ink(
            // height: 55.0,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              //analizar
              // border: Border.all(color: widget.habit.color, width: 2.5),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50.0,
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: done
                            ? Image.asset('assets/png/diamond_done.png')
                            : Image.asset('assets/png/diamond_todo.png'),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          ('${widget.habit.name} ${getChecklistCounter()}')
                              .trim(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            shadows: [
                              Shadow(color: Colors.white, offset: Offset(0, -5))
                            ],
                            fontSize: 20.0,
                            color: Colors.transparent,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.yellow,
                          ),
                          minFontSize: 10.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.habit.streak > 999
                                ? '+999'
                                : widget.habit.streak.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          const SizedBox(width: 5.0),
                          const SvgIcon(
                            'assets/svg/diamond_done.svg',
                            color: Colors.white,
                            height: 15.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CheckListWidget(
                    habit: widget.habit, showChecklist: showChecklist),
              ],
            )),
      ),
    );
  }

  getChecklistCounter() {
    if (widget.habit.checkList?.isNotEmpty ?? false) {
      int doneCounter = 0;
      for (CheckListEntity checkItem in widget.habit.checkList!) {
        if (checkItem.done) doneCounter++;
      }
      return '$doneCounter/${widget.habit.checkList!.length}';
    }
    return '';
  }
}

class CheckListWidget extends StatelessWidget {
  const CheckListWidget({
    super.key,
    required this.habit,
    required this.showChecklist,
  });

  final HabitEntity habit;
  final bool showChecklist;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (habit.checkList?.isNotEmpty ?? false) && showChecklist,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (habit.checkList?.isNotEmpty ?? false)
            for (CheckListEntity checkItem in habit.checkList!)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5),
                child: InkWell(
                  onTap: () {
                    print('checkItem done');
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                        color: kAccentColor,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(kBorderRadious))),
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: checkItem.done
                              ? Image.asset('assets/png/diamond_done.png',
                                  height: 25.0)
                              : Image.asset(
                                  'assets/png/diamond_todo.png',
                                  height: 25.0,
                                ),
                        ),
                        const SizedBox(width: 15.0),
                        Expanded(
                          child: AutoSizeText(
                            checkItem.name,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
