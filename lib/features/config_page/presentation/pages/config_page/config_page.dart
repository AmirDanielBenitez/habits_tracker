import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker/core/constants/constants.dart';
import 'package:habits_tracker/injection_container.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Config',
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
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Language',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            DropdownButton(
              // icon: CircleFlag('us', size: 25.0),

              items: [
                DropdownMenuItem(
                  value: const Locale('en'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'English',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 10.0),
                      CircleFlag('us', size: 25.0),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: const Locale('es'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Español',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 10.0),
                      CircleFlag('es', size: 25.0),
                    ],
                  ),
                ),
              ],
              dropdownColor: kPrimaryColor,
              onChanged: (v) {},
              value: const Locale('en'),
              // value: AppLocalizations.of(context).locale,
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                sl<PackageInfo>().version,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
