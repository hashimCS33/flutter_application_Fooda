import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';

class FoodCategory extends StatelessWidget {
  const FoodCategory({
    super.key,
    required this.category,
    required this.selectedIndex,
    this.onSelected,
  });
  final int selectedIndex;
  final List category;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: List.generate(category.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onSelected?.call(index),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppColors.primary
                          : const Color.fromARGB(255, 229, 228, 228),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color:
                        isSelected
                            ? AppColors.primary
                            : Colors.grey.shade400, // تغيير اللون بحسب الحالة
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.20),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: CustomText(
                  text: category[index],
                  color: isSelected ? Colors.white : Colors.black87,
                  fontweight: FontWeight.w500,
                  fontsize: 18,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
