import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/text_style.dart';

class NoDataStateMessage extends StatelessWidget {
  const NoDataStateMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Maaf, data tidak tersedia.",
            style: textTheme.subtitle1
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
  }
}
