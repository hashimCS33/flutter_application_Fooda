import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({
    super.key,
    required this.productimage,
    required double sliderValue,
    required ValueChanged<double> onSliderChanged,
  }) : value = sliderValue,
       _onChanged = onSliderChanged;

  final String productimage;

  final double value;
  final ValueChanged<double> _onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(productimage),
        Gap(10),
        CustomText(
          text: 'Customize Your Burger to Your Tastes.\n Ultimate Experience',
          fontweight: FontWeight.bold,
          maxLines: 5,
        ),
        Gap(10),
        Slider(
          min: 0,
          max: 1,
          value: value,
          onChanged: _onChanged,
          inactiveColor: Colors.grey.shade300,
          activeColor: AppColors.primary,
        ),
        Row(
          children: [
            Gap(40),
            CustomText(
              text: 'Cold 🥶',
              color: const Color.fromARGB(255, 2, 2, 2),
            ),
            Gap(200),
            CustomText(
              text: 'Hot 🌶️',
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ],
    );
  }
}
