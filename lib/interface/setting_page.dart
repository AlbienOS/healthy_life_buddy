import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/provider/preferences_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pengaturan",
                    style: textTheme.headline5?.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark Mode",
                        style: textTheme.subtitle1?.apply(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      Switch.adaptive(
                          value: provider.isDarkTheme,
                          onChanged: (value) {
                            provider.enableDarkTheme(value);
                          }),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
