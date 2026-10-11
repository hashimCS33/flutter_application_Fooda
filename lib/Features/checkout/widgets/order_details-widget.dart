import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:gap/gap.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.deliveryFees,
    required this.total,
    required this.estimatedTime,
  });
  final String order, taxes, deliveryFees, total, estimatedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkoutWidget(
          title: 'order',
          price: order,
          isBlod: false,
          isSmall: false,
        ),
        Gap(10),
        checkoutWidget(
          title: 'Taxes',
          price: taxes,
          isBlod: false,
          isSmall: false,
        ),
        Gap(10),
        checkoutWidget(
          title: 'Delivery fees',
          price: deliveryFees,
          isBlod: false,
          isSmall: false,
        ),

        Divider(height: 40, thickness: 1, color: Colors.grey.shade300),
        Gap(10),
        checkoutWidget(
          title: 'Total',
          price: total,
          isBlod: true,
          isSmall: false,
        ),
        Gap(10),
        checkoutWidget(
          title: 'Estimated Delivery time ',
          price: estimatedTime,
          isBlod: true,
          isSmall: true,
        ),
      ],
    );
  }
}

Widget checkoutWidget({
  required String title,
  required String price,
  required bool isBlod,
  required bool isSmall,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        fontweight: isBlod ? FontWeight.bold : FontWeight.w400,
        fontsize: isSmall ? 13 : 15,
        color: isBlod ? Colors.black : Colors.grey,
      ),

      CustomText(
        text: '$price \$',
        fontweight: isBlod ? FontWeight.bold : FontWeight.w400,
        fontsize: isSmall ? 13 : 15,
        color: isBlod ? Colors.black : Colors.grey,
      ),
    ],
  );
}
