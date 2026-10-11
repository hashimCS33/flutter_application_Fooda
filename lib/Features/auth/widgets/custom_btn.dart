import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({
    super.key,
    required this.onTap,
    this.text,
    required this.color,
    this.fontsize = 18,
    this.fontweight = FontWeight.w500,
    this.borderColor,
    this.backgroundColor = Colors.transparent,
    this.height = 50,
    this.width,
    this.textColor,
    this.showbroder = true,
    this.icon,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final String? text;
  final Color color;
  final double fontsize;
  final FontWeight fontweight;
  final Color? borderColor;
  final Color backgroundColor;
  final double height;
  final double? width;
  final Color? textColor;
  final bool showbroder;
  final bool isLoading;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side:
              showbroder
                  ? BorderSide(color: borderColor ?? color, width: 1.5)
                  : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CupertinoActivityIndicator(color: Colors.white),
            if (isLoading) const SizedBox(width: 8),
            if (isLoading == false && text != null)
              Text(
                text ?? '',
                style: TextStyle(
                  color: textColor ?? color,
                  fontSize: fontsize,
                  fontWeight: fontweight,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
