import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';

class CustomTextfild extends StatefulWidget {
  const CustomTextfild({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
  });

  final String hintText;
  final bool isPassword;

  final TextEditingController controller;

  @override
  State<CustomTextfild> createState() => _CustomTextfildState();
}

class _CustomTextfildState extends State<CustomTextfild> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorHeight: 20,
      cursorColor: AppColors.primary,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon:
            widget.isPassword
                ? GestureDetector(
                  onTap: () => _toggleObscureText(),
                  child: Icon(
                    _obscureText
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                  ),
                )
                : null,
        prefixIcon:
            widget.isPassword
                ? const Icon(Icons.lock)
                : const Icon(Icons.email),
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
