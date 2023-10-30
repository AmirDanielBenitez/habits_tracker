import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../../../core/constants/constants.dart';

class HabitTile extends StatefulWidget {
  final String habitName;
  final bool done;
  final int streak;
  const HabitTile({
    super.key,
    required this.habitName,
    this.done = false,
    this.streak = 0,
  });

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  late bool done;

  @override
  void initState() {
    super.initState();
    done = widget.done;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        HapticFeedback.vibrate();
        setState(() {
          done = !done;
        });
      },
      child: Container(
          height: 55.0,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            //analizar
            // border: Border.all(color: Colors.red, width: 2.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                  widget.habitName,
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
                    widget.streak > 999 ? '+999' : widget.streak.toString(),
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
          )),
    );
  }
}
