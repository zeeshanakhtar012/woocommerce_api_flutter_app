import 'package:flutter/material.dart';

import '../constants/fonts.dart';

class CustomTextDisplay extends StatelessWidget {
  final String text;

  CustomTextDisplay({required this.text});

  @override
  Widget build(BuildContext context) {
    List<String> words = text.split(' ');
    List<String> firstLineWords = words.take(5).toList();
    List<String> remainingWords = words.skip(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: firstLineWords.join(' '),
            style: AppFontsStyle.editButton,
          ),
        ),
        ...remainingWords.map((word) => Text(
          word,
            style: AppFontsStyle.editButton,
        )),
      ],
    );
  }
}
