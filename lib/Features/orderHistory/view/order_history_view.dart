import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/orderHistory/cubit/orders_cubit.dart';
import 'package:flutter_application_hungray/Features/orderHistory/cubit/orders_states.dart';
import 'package:flutter_application_hungray/shared/custom_button.dart';
import 'package:flutter_application_hungray/shared/custom_snack.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersCubit, OrdersState>(
      listenWhen: (p, c) => c.message != null,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(CustomSnackBar(state.message!));
      },
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final state = context.watch<OrdersCubit>().state;
    final isLoading = state.isLoading;
    final orders = state.orders;
    Future<void> fetchOrders() => context.read<OrdersCubit>().fetchOrders();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Builder(
        builder: (_) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orders.isEmpty) {
            return RefreshIndicator(
              onRefresh: fetchOrders,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 72,
                            color: Colors.grey.shade400,
                          ),
                          const Gap(12),
                          const CustomText(
                            text: 'No orders yet',
                            fontweight: FontWeight.bold,
                            fontsize: 16,
                          ),
                          const Gap(6),
                          CustomText(
                            text: 'Your past orders will show up here',
                            fontsize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: fetchOrders,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: orders.length,
                padding: const EdgeInsets.only(top: 10, bottom: 120),
                itemBuilder: (_, index) {
                  final order = orders[index];

                  return Card(
                    color: Colors.white,
                    borderOnForeground: true,
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Order #${order.id}',
                                fontweight: FontWeight.bold,
                              ),
                              CustomText(
                                text: order.status,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                          const Gap(10),
                          for (final item in order.items)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.image,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, __, ___) => Container(
                                            width: 60,
                                            height: 60,
                                            color: Colors.grey.shade200,
                                          ),
                                    ),
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: item.name,
                                          fontweight: FontWeight.bold,
                                        ),
                                        CustomText(
                                          text: 'Qty : x${item.quantity}',
                                        ),
                                        CustomText(
                                          text: 'Price : \$${item.price}',
                                          fontweight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Divider(color: Colors.grey.shade300),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Total',
                                fontweight: FontWeight.bold,
                              ),
                              CustomText(
                                text: '\$${order.total}',
                                fontweight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Gap(15),
                          CustomButton(
                            text: 'Order Again',
                            onPressed: () {},
                            width: double.infinity,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
