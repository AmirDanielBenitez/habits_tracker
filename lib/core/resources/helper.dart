import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habits_tracker/core/database.dart';
import 'package:habits_tracker/features/config_page/presentation/bloc/bloc/config_bloc.dart';
import 'package:habits_tracker/injection_container.dart';

showToast(String text, {bool error = false}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: error ? Colors.red : kAccentColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print("state changed ${state.name}");
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}

List<int> getDaysSequence(int lastDone, int differenceDays) {
  const int maxSequenceLength = 7;
  List<int> secuencia = [1, 2, 3, 4, 5, 6, 7];
  int rotationIndex = lastDone % maxSequenceLength;

  if (differenceDays > maxSequenceLength) {
    differenceDays = maxSequenceLength;
  } else if (differenceDays < 1) {
    differenceDays = 1;
  }

  List<int> resultado = [
    ...secuencia.sublist(rotationIndex),
    ...secuencia.sublist(0, rotationIndex)
  ].take(differenceDays).toList();

  return resultado;
}

AppLocalizations ln(BuildContext context) {
  return AppLocalizations.of(context)!;
}

getLocale(ConfigState state) {
  try {
    if (state is ConfigLoaded && state.config.locale != null) {
      return Locale(state.config.locale!);
    }
    if (sl<ConfigItem>().locale != null) {
      return Locale(sl<ConfigItem>().locale!);
    }
    return null;
  } catch (e) {
    return null;
  }
}
