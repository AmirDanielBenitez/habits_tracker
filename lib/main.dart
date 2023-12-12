import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits_tracker/config/routes/routes.dart';
import 'package:habits_tracker/config/theme/app_themes.dart';
import 'package:habits_tracker/core/resources/helper.dart';
import 'package:habits_tracker/features/config_page/presentation/bloc/bloc/config_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/bloc/habits_bloc.dart';
import 'package:habits_tracker/features/habits_tracker/presentation/pages/home_habits/home_habits.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habits_tracker/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitsBloc>(
          create: (context) => sl()..add(LoadHabitsEvent()),
        ),
        BlocProvider<ConfigBloc>(
          create: (context) => sl()..add(LoadConfigEvent()),
        ),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // locale: Locale('es'),

            locale: getLocale(state),
            // locale: sl<ConfigItem>().locale != null
            //     ? Locale(sl<ConfigItem>().locale!)
            //     : null,
            // locale: appLocale != null ? Locale(appLocale!.languageCode) : null,

            supportedLocales: L10n.all,
            home: const HomeHabits(),
          );
        },
      ),
    );
  }
}
