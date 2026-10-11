import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

SnackBar CustomSnackBar(errorMsg) {
  return SnackBar(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: Colors.red.shade900,
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(14),

        Expanded(
          child: CustomText(
            text: errorMsg,
            color: Colors.white,
            fontsize: 12,
            fontweight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
