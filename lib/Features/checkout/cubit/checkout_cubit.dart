import 'package:flutter_bloc/flutter_bloc.dart';

/// Holds the selected payment method id ('cash' or 'Visa').
class CheckoutCubit extends Cubit<String> {
  CheckoutCubit() : super('Visa');

  void selectPayment(String method) => emit(method);
}
