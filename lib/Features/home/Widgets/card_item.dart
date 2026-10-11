import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.rating,
    this.onFavoriteTap,
  });

  final String image;
  final String name;
  final String description;
  final String rating;
  final VoidCallback? onFavoriteTap;

  static const double _imageHeight = 110;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 250, 250, 250),
            const Color.fromARGB(255, 137, 136, 136),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: _imageHeight,
              child: _buildImage(),
            ),
          ),
          const Gap(8),
          CustomText(
            text: name,
            fontweight: FontWeight.w700,
            fontsize: 15,
            color: AppColors.primary,
            maxLines: 2,
          ),
          const Gap(2),
          SizedBox(
            height: 30,
            child: CustomText(
              text: description,
              fontweight: FontWeight.w400,
              fontsize: 12,
              color: const Color.fromARGB(255, 15, 14, 14),
              maxLines: 2,
            ),
          ),
          const Gap(17),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const Gap(4),
              CustomText(
                text: rating,
                fontweight: FontWeight.w600,
                fontsize: 15,
                color: AppColors.primary,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onFavoriteTap,
                child: const Icon(
                  Icons.favorite_border,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (image.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        child: const Icon(Icons.fastfood, color: Colors.grey),
      );
    }
    return Image.network(
      image,
      fit: BoxFit.cover,
      errorBuilder:
          (context, error, stackTrace) => Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
    );
  }
}
