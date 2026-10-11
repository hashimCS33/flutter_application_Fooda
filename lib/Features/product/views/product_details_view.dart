import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/product/cubit/product_details_cubit.dart';
import 'package:flutter_application_hungray/Features/product/cubit/product_details_states.dart';
import 'package:flutter_application_hungray/Features/product/widget/spicy_slider.dart';
import 'package:flutter_application_hungray/Features/product/widget/topping_card.dart';
import 'package:flutter_application_hungray/shared/custom_button.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.productimage,
    required this.productid,
    required this.productPrice,
  });
  final String productimage;
  final int productid;
  final String productPrice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit(productId: productid)..load(),
      child: BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listenWhen: (p, c) => c.message != null,
        listener: (context, state) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        },
        child: Builder(builder: _buildScaffold),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final state = context.watch<ProductDetailsCubit>().state;
    final sliderValue = state.spicy;
    final isLoading = state.isAdding;
    final selectedToppings = state.selectedToppings;
    final selectedSideOptions = state.selectedSideOptions;
    final toppings = state.toppings;
    final sideOptions = state.sideOptions;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Product Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpicySlider(
                productimage: productimage,
                sliderValue: sliderValue, //بيه سالفة
                onSliderChanged:
                    (value) =>
                        context.read<ProductDetailsCubit>().setSpicy(value),
              ),
            ),

            const Gap(24),

            /// Toppings Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: 'toppings',
                fontweight: FontWeight.bold,
                fontsize: 20,
              ),
            ),
            const Gap(8),
            SizedBox(
              height: 180,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(toppings.length, (index) {
                    final topping = toppings[index];
                    final id = topping.id ?? 1;
                    final isSelected = selectedToppings.contains(id);

                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ToppingCard(
                        color: isSelected ? Colors.green : null,
                        title: topping.name,
                        imageurl: topping.image,
                        onAddTap:
                            () => context
                                .read<ProductDetailsCubit>()
                                .toggleTopping(id),
                      ),
                    );
                  }),
                ),
              ),
            ),

            const Gap(10),

            /// Side Options Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: 'Side Options',
                fontweight: FontWeight.bold,
                fontsize: 20,
              ),
            ),
            const Gap(5),
            SizedBox(
              height: 180,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(sideOptions.length, (index) {
                    final sideOption = sideOptions[index];
                    final id = sideOptions[index].id ?? 1;
                    final isSelected = selectedSideOptions.contains(id);
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ToppingCard(
                        color: isSelected ? Colors.green : null,
                        title: sideOption.name,
                        imageurl: sideOption.image,
                        onAddTap:
                            () => context
                                .read<ProductDetailsCubit>()
                                .toggleSideOption(id),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const Gap(40),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: BoxDecoration(
          color: Color(0xFF1B4332),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Burger price :',
                  color: Colors.white70,
                  fontweight: FontWeight.normal,
                  fontsize: 14,
                ),
                const Gap(6),
                CustomText(
                  text: '\$ $productPrice',
                  fontweight: FontWeight.bold,
                  fontsize: 25,
                  color: Colors.white,
                ),
              ],
            ),
            CustomButton(
              width: 160,
              color: Colors.white,
              text: 'Add to Cart ',
              textColor: Colors.black,
              icon: isLoading ? null : Icons.shopping_cart_checkout_outlined,
              iconWidget:
                  isLoading
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CupertinoActivityIndicator(color: Colors.black),
                      )
                      : null,

              onPressed: () => context.read<ProductDetailsCubit>().addToCart(),
            ),
          ],
        ),
      ),
    );
  }
}
