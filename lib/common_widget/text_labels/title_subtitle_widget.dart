import 'package:flutter/material.dart';

import 'title_heading1_widget.dart';

class TitleSubTitleWidget extends StatelessWidget {
  const TitleSubTitleWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.crossAxisAlignment = CrossAxisAlignment.start})
      : super(key: key);
  final String title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        TitleHeading1Widget(
          text: title,
          padding: const EdgeInsets.only(bottom: 12),
            fontWeight: FontWeight.bold,
            color: Colors.blue
        ),
        TitleHeading1Widget(
          text: subtitle,
          opacity: .7,
          maxLines: 2,
          textAlign: TextAlign.left,
          color: Colors.purple,
          padding: const EdgeInsets.only(left: 6),
        ),
      ],
    );
  }
}
