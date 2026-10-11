import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Features/orderHistory/cubit/orders_states.dart';
import 'package:flutter_application_hungray/Features/orderHistory/data/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());

  final OrderRepo orderRepo = OrderRepo();

  Future<void> fetchOrders() async {
    emit(state.copyWith(isLoading: true));
    try {
      final orders = await orderRepo.getOrders();
      if (isClosed) return;
      emit(state.copyWith(isLoading: false, orders: orders));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          message: e is ApiErorr ? e.message : 'Failed to fetch order history',
        ),
      );
    }
  }
}
