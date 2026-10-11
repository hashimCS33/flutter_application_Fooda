import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ToppingCard extends StatelessWidget {
  final String title;
  final String imageurl;
  final VoidCallback onAddTap;
  final Color? color;

  const ToppingCard({
    this.color,
    super.key,
    required this.title,
    required this.imageurl,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddTap,
      child: SizedBox(
        width: 140,
        height: 175,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Gap(8),
              // 1. الطبقة الوسطى: الحاوية البيضاء تغطي الجزء العلوي وتنحني فوق الجوزي
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 105, // تحديد مساحة اللون الأبيض
                child: Container(
                  decoration: BoxDecoration(
                    color: color ?? Colors.white, // اللون الأبيض
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              // 2. الطبقة العليا: صورة الطماطم (تظهر فوق الأبيض وفوق الجوزي بنفس الوقت)
              Positioned(
                top: 10,
                left: 14,
                right: 14,
                height: 90, // ارتفاع الصورة لتغطية مساحتها بالكامل
                child: Image.network(
                  imageurl,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.fastfood,
                        color: Colors.grey,
                        size: 40,
                      ),
                ),
              ),

              // 3. طبقة النصوص والزر في الأسفل (فوق الخلفية الجوزية)
              Positioned(
                left: 20,
                right: 20,
                bottom: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomText(
                        text: title,
                        color: const Color.fromARGB(255, 7, 7, 7),
                        fontweight: FontWeight.w500,
                        fontsize: 15,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Gap(8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
