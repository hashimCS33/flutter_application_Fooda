import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Color? color;
  final double? height;
  final double? radius;
  final Color? textColor;
  final IconData? icon;
  final Widget? iconWidget;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.color,
    this.height,
    this.radius,
    this.textColor,
    this.icon,
    this.iconWidget,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Color? ColorText =
        widget.textColor ?? (widget.color != null ? Colors.white : null);
    return SizedBox(
      width: widget.width,
      height: widget.height ?? 48,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              iconColor: Colors.white,
              backgroundColor: widget.color ?? AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 14),
              ),
            ),

            child: CustomText(
              text: widget.text,
              color: ColorText,
              fontweight: FontWeight.bold,
              fontsize: 16,
              icon: widget.icon,
              iconWidget: widget.iconWidget,
            ),
          ),
        ],
      ),
    );
  }
}
