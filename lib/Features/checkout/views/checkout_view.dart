import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_cubit.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_states.dart';
import 'package:flutter_application_hungray/Features/checkout/cubit/checkout_cubit.dart';
import 'package:flutter_application_hungray/Features/checkout/widgets/order_details-widget.dart';
import 'package:flutter_application_hungray/shared/custom_button.dart';
import 'package:flutter_application_hungray/shared/custom_snack.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.totalpric});
  final String totalpric;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()..refresh()),
        BlocProvider(create: (_) => CheckoutCubit()),
      ],
      child: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (p, c) => c.message != null,
        listener: (context, state) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(state.message!));
        },
        child: Builder(builder: _buildScaffold),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final selectedPaymentMethod = context.watch<CheckoutCubit>().state;
    final userModel = context.watch<ProfileCubit>().state.user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order Summary',
                fontweight: FontWeight.w500,
                fontsize: 20,
              ),
              Gap(10),
              OrderDetailsWidget(
                order: totalpric,
                taxes: '3.5',
                deliveryFees: '40.33',
                total: (double.parse(totalpric) + 3.5 + 40.33).toStringAsFixed(
                  2,
                ),
                estimatedTime: '15 - 30 m',
              ),
              Gap(80),
              CustomText(
                text: 'Payment Method',
                fontweight: FontWeight.w500,
                fontsize: 20,
              ),
              Gap(20),

              ///Cash on Delivery
              ListTile(
                onTap: () => cubit.selectPayment('cash'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                tileColor: Color(0xFF3C2F2F),
                leading: Image.asset('assets/icons/cash.png'),
                title: CustomText(
                  text: 'Cash on Delivery',
                  fontweight: FontWeight.w400,
                  fontsize: 16,
                  color: Colors.white,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'cash',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) => cubit.selectPayment(value!),
                ),
              ),
              Gap(10),

              //Debit/Credit Card
              userModel?.visa == null
                  ? SizedBox.shrink()
                  : ListTile(
                    onTap: () => cubit.selectPayment('Visa'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 16,
                    ),
                    tileColor: Colors.blue.shade900,
                    leading: Image.asset(
                      'assets/icons/visa.png',
                      color: Colors.white,
                    ),
                    title: CustomText(
                      text: 'Debit/Credit Card',
                      fontweight: FontWeight.w400,
                      fontsize: 16,
                      color: Colors.white,
                    ),

                    subtitle: SizedBox(
                      height: 20,

                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade500,
                        period: Duration(seconds: 2),

                        child: CustomText(
                          text:
                              userModel?.visa ??
                              '**** **** 1234   Visa, MasterCard, Amex',
                          fontweight: FontWeight.w400,
                          fontsize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    trailing: Radio<String>(
                      activeColor: Colors.white,
                      value: 'Visa',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) => cubit.selectPayment(value!),
                    ),
                  ),
              Gap(5),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    value: true,
                    onChanged: (value) {},
                  ),
                  CustomText(
                    text: 'Save this card for future payments',
                    fontweight: FontWeight.w400,
                    fontsize: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
              Gap(200),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        height: 110,

        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Total ',
                    color: Colors.grey,
                    fontweight: FontWeight.bold,
                    fontsize: 18,
                  ),
                  CustomText(
                    text:
                        '\$ ${(double.parse(totalpric) + 3.5 + 40.33).toStringAsFixed(2)}',
                    fontweight: FontWeight.bold,
                    fontsize: 24,
                  ),
                ],
              ),
              const Gap(20),
              CustomButton(
                text: 'Pay Now',
                height: 55,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (hashim) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 30,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                              const Gap(24),
                              const CustomText(
                                text: 'Success!',
                                fontweight: FontWeight.bold,
                                fontsize: 22,
                                color: Colors.black,
                              ),
                              const Gap(16),
                              Text(
                                'Your payment was successful.\nA receipt for this purchase\nhas been sent to your email.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                              const Gap(30),
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  text: 'Close',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
