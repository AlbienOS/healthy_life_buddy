import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: onSurfaceColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: surfaceColor,
      ),
    );
  }
}
