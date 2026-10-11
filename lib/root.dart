import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_cubit.dart';
import 'package:flutter_application_hungray/Features/cart/cubit/cart_cubit.dart';
import 'package:flutter_application_hungray/Features/home/cubit/home_cubit.dart';
import 'package:flutter_application_hungray/Features/orderHistory/cubit/orders_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_hungray/Features/cart/view/CartView.dart';
import 'package:flutter_application_hungray/Features/auth/view/profile_view.dart';
import 'package:flutter_application_hungray/Features/home/views/HomeView.dart';
import 'package:flutter_application_hungray/Features/orderHistory/view/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late PageController cntroller;
  int currentScreen = 0;

  static const int _pageCount = 4;

  @override
  void initState() {
    super.initState();
    cntroller = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    cntroller.dispose();
    super.dispose();
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => HomeCubit()..getProducts()),
            BlocProvider(create: (_) => ProfileCubit()..refresh(silent: true)),
          ],
          child: const HomeView(),
        );
      case 1:
        return BlocProvider(
          create: (_) => CartCubit()..fetchCart(),
          child: const CartView(),
        );
      case 2:
        return BlocProvider(
          create: (_) => OrdersCubit()..fetchOrders(),
          child: const OrderHistoryView(),
        );
      case 3:
      default:
        return BlocProvider(
          create: (_) => ProfileCubit()..load(),
          child: const ProfileView(),
        );
    }
  }

  void _onTapNavItem(int index) {
    cntroller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentScreen = index);
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final bool selected = currentScreen == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onTapNavItem(index),
      child:
          selected
              ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                height: 200,
                width: 59,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 168, 168, 168),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(selectedIcon, color: AppColors.primary, size: 20),
                    const SizedBox(width: 6),
                  ],
                ),
              )
              : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: const Color.fromARGB(255, 16, 16, 16),
                    size: 22,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color.fromARGB(255, 5, 5, 5),
                    ),
                  ),
                ],
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.custom(
            controller: cntroller,
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => _buildPage(index),
              childCount: _pageCount,
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  240,
                  167,
                  167,
                ).withValues(alpha: 0.90),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 151, 137, 137),
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsetsGeometry.fromLTRB(20, 14, 20, 14),
                child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(
                        index: 0,
                        icon: CupertinoIcons.home,
                        selectedIcon: CupertinoIcons.home,
                        label: 'Home',
                      ),
                      _buildNavItem(
                        index: 1,
                        icon: CupertinoIcons.cart,
                        selectedIcon: CupertinoIcons.cart,
                        label: 'Cart',
                      ),
                      _buildNavItem(
                        index: 2,
                        icon: Icons.local_restaurant_sharp,
                        selectedIcon: Icons.local_restaurant_sharp,
                        label: 'History',
                      ),
                      _buildNavItem(
                        index: 3,
                        icon: CupertinoIcons.person,
                        selectedIcon: CupertinoIcons.back,
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
