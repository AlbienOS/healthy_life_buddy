import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/provider/preferences_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Column(
            children: [
              Material(
                child: ListTile(
                  title: Text("Dark Theme"),
                  trailing: Switch.adaptive(
                      value: provider.isDarkTheme,
                      onChanged: (value) {
                        provider.enableDarkTheme(value);
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
