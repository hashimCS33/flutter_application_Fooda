import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontweight,
    this.fontsize,
    this.maxLines,
    this.overflow,
    this.icon,
    this.iconWidget,
  });

  final String text;
  final Color? color;
  final FontWeight? fontweight;
  final double? fontsize;
  final int? maxLines;
  final TextOverflow? overflow;
  final IconData? icon;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: overflow ?? TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontsize,
              fontWeight: fontweight,
              color: color,
            ),
          ),
        ),
        if (iconWidget != null) ...[
          Gap(4),
          iconWidget!,
        ] else if (icon != null) ...[
          Gap(4),
          Icon(icon, color: color ?? Colors.black),
        ],
      ],
    );
  }
}
