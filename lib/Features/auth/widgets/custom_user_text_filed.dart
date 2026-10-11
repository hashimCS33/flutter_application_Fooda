import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';

class CustomUserTextField extends StatefulWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType,
    this.borderColor,
    this.width,
    this.hinttext,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final double? width;
  final String? hinttext;

  @override
  State<CustomUserTextField> createState() => _CustomUserTextFieldState();
}

class _CustomUserTextFieldState extends State<CustomUserTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final Color color =
        widget.borderColor ??
        AppColors
            .primary; // Use the provided borderColor or default to AppColors.primary

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      child: SizedBox(
        width: widget.width,
        child: TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: _obscureText,
          cursorColor: Colors.black54,
          cursorHeight: 20,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '${widget.labelText} مطلوب';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hinttext,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            labelText: widget.labelText,
            labelStyle: TextStyle(color: color, fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: false,
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : widget.suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            errorStyle: const TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 1.5),
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
