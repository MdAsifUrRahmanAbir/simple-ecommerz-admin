import 'package:flutter/material.dart';

import '../../../utils/custom_color.dart';

class TitleHeading1Widget extends StatelessWidget {
  const TitleHeading1Widget({
    Key? key,
    required this.text,
    this.textAlign,
    this.textOverflow,
    this.padding = paddingValue,
    this.opacity = 1.0,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  static const paddingValue = EdgeInsets.all(0.0);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize ?? 24,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: color ?? CustomColor.primaryTextColor
          ),
          textAlign: textAlign ?? TextAlign.center,
          overflow: textOverflow ?? TextOverflow.ellipsis,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
