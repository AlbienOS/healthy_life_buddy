import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key, required this.text, required this.subjectText})
      : super(key: key);

  final String text;
  final String subjectText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        child: SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            icon: const Icon(
              Icons.share,
              color: primaryColor,
            ),
            onPressed: () {
              Share.share(text, subject: subjectText);
            },
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: surfaceColor,
        ),
      ),
    );
  }
}
