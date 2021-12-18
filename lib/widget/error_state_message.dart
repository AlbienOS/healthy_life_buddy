import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/text_style.dart';

class ErrorStateMessage extends StatelessWidget {
  const ErrorStateMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error,
              size: 50, color: Theme.of(context).colorScheme.error),
          Text(
            "Maaf, terjadi error.",
            style: textTheme.subtitle1
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
  }
}
