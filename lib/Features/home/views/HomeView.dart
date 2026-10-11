import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/card_item.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/food_catrgory.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/search_field.dart';
import 'package:flutter_application_hungray/Features/home/Widgets/user_header.dart';
import 'package:flutter_application_hungray/Features/home/cubit/home_cubit.dart';
import 'package:flutter_application_hungray/Features/home/cubit/home_states.dart';
import 'package:flutter_application_hungray/Features/product/views/product_details_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List category = ['All', 'Combo', 'Sliders', 'Classic'];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final products = state.products;
            final isLoading = state.isLoading;
            return ScrollConfiguration(
              // Disable the Android stretch overscroll effect that reveals a blank gap above the pinned header.
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(overscroll: false),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor:Colors.transparent,
                    elevation: 10,
                    automaticallyImplyLeading: false,
                    floating: false,
                    pinned: true,
                    toolbarHeight: 200,
                    scrolledUnderElevation: 10,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          
                          const UserHeader(),
                          const Gap(30),
                          SearchField(
                            controller: _searchController,
                            onChanged: cubit.onSearchChanged,
                          ),
                          
                        ],
                        
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: FoodCategory(
                        category: category,
                        selectedIndex: state.selectedCategory,
                        onSelected: cubit.selectCategory,
                      ),
                    ),
                    
                  ),

                       

                  
                  

                  ///GridView
                  if (isLoading)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if ((products ?? []).isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const Gap(12),
                            Text(
                              'No food found',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      sliver: SliverGrid.builder(
                        itemCount: products.length ?? 0,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return GestureDetector(
                            onTap: () {
                              // Navigate to the product details view when a card is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ProductDetailsView(
                                        productimage: product.image,
                                        productid: product.id,
                                        productPrice: product.price,
                                      ),
                                ),
                              );
                            },
                            child: CardItem(
                              image: product.image ?? '',
                              name: product.name ?? '',
                              description: product.desc ?? '',
                              rating: product.rate ?? ' ',
                            ),
                          );
                        },

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 235,
                            ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
