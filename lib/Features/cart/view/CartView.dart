import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/cart/cubit/cart_cubit.dart';
import 'package:flutter_application_hungray/Features/cart/cubit/cart_states.dart';
import 'package:flutter_application_hungray/Features/cart/widgets/cart_item.dart';
import 'package:flutter_application_hungray/Features/checkout/views/checkout_view.dart';
import 'package:flutter_application_hungray/shared/custom_snack.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
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
    final cubit = context.read<CartCubit>();
    final state = context.watch<CartCubit>().state;
    final isLoading = state.isLoading;
    final cartResponse = state.cart;
    final quantitys = state.quantities;
    Future<void> fetchCart() => cubit.fetchCart();
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Builder(
              builder: (_) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = cartResponse?.cartData.items ?? [];

                if (items.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: fetchCart,
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
                                  Icons.shopping_cart_outlined,
                                  size: 72,
                                  color: Colors.grey.shade400,
                                ),
                                const Gap(12),
                                const CustomText(
                                  text: 'Your cart is empty',
                                  fontweight: FontWeight.bold,
                                  fontsize: 16,
                                ),
                                const Gap(6),
                                CustomText(
                                  text: 'Items you add will show up here',
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
                  onRefresh: fetchCart,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 16, bottom: 130),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Gap(10),
                    itemBuilder: (_, index) {
                      final item = items[index];

                      return CartItem(
                        image: item.image,
                        text: item.name,
                        desc: 'Veggie Burger',
                        spicy: item.spicy,
                        onAdd: () => cubit.increment(index),
                        onMins: () => cubit.decrement(index),
                        onRemoveItem: () => cubit.removeItem(item.item_id),
                        num: quantitys[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                1,
                96,
                48,
              ).withValues(alpha: 0.70),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    0,
                    62,
                    0,
                  ).withValues(alpha: 0.20),
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(10),
                Center(
                  child: Container(
                    height: 45,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CheckoutView(
                                    totalpric:
                                        '${cartResponse?.cartData.total_price}',
                                  ),
                            ),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'checkout',
                            fontweight: FontWeight.bold,
                            fontsize: 17,
                            color: const Color.fromARGB(255, 5, 5, 5),
                          ),
                          Gap(50),
                          CustomText(
                            text:
                                '${cartResponse?.cartData.total_price}\$' ??
                                '0\$',
                            fontweight: FontWeight.bold,
                            fontsize: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Gap(100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
