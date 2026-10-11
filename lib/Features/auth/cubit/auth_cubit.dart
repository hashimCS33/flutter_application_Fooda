import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/auth_states.dart';
import 'package:flutter_application_hungray/Features/auth/data/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthRepo authRepo = AuthRepo();

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepo.login(email, password);
      if (isClosed) return;
      emit(AuthSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(AuthError(_messageOf(e)));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.signup(name, email, password);
      if (isClosed) return;
      if (user == null) {
        emit(AuthError('Signup failed'));
        return;
      }
      emit(AuthSignupSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(AuthError(_messageOf(e)));
    }
  }

  String _messageOf(Object e) =>
      e is ApiErorr ? e.message : 'something went wrong';

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
