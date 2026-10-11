import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.onAdd,
    required this.onMins,
    required this.onRemoveItem,
    required this.num,
    this.spicy,
  });
  final String image, text, desc;
  final VoidCallback onAdd;
  final VoidCallback onMins;
  final VoidCallback onRemoveItem;
  final int num;
  final double? spicy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(image, width: 100, fit: BoxFit.contain),
                    const Gap(4),
                    CustomText(text: text, fontweight: FontWeight.bold),
                    CustomText(text: desc),
                    if (spicy != null) ...[
                      const Gap(4),
                      CustomText(
                        text: 'Spicy: ${(spicy! * 100).round()}%',
                        fontsize: 12,
                        color: Colors.redAccent,
                      ),
                    ],
                  ],
                ),
              ),

              const Gap(16),

              Column(
                children: [
                  const Gap(16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onAdd,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            CupertinoIcons.add,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(20),
                      CustomText(
                        text: num.toString(),
                        fontweight: FontWeight.w400,
                        fontsize: 20,
                      ),
                      const Gap(20),
                      GestureDetector(
                        onTap: onMins,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primary,
                          child: const Icon(
                            CupertinoIcons.minus,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Gap(30),
                  SizedBox(
                    width: 130,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: onRemoveItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const CustomText(
                        text: 'Remove',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
