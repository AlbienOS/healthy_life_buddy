import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/text_style.dart';

class AppHeadline extends StatelessWidget {
  const AppHeadline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Healthy Life \nBuddy',
        style: textTheme.headline5
            ?.apply(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
