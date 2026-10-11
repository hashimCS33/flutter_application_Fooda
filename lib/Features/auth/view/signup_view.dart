import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/auth_cubit.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/auth_states.dart';
import 'package:flutter_application_hungray/Features/auth/view/login_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/shared/custom_snack.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthCubit(), child: const _SignupBody());
  }
}

class _SignupBody extends StatelessWidget {
  const _SignupBody();

  void _submit(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.signup(
        cubit.nameController.text.trim(),
        cubit.emailController.text.trim(),
        cubit.passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSignupSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => const LoginView()),
            (route) => false,
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(CustomSnackBar(state.message));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: context.read<AuthCubit>().formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    const Gap(36),
                    SvgPicture.asset(
                      "assets/logo/logo.svg",
                      colorFilter: ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                      height: 58,
                    ),
                    const Gap(18),
                    const Text(
                      "Create an account",
                      style: TextStyle(
                        color: Color(0xFF565656),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Gap(40),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F0EA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          CustomUserTextField(
                            controller:
                                context.read<AuthCubit>().nameController,
                            labelText: "Name",
                          ),
                          const Gap(14),
                          CustomUserTextField(
                            controller:
                                context.read<AuthCubit>().emailController,
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const Gap(14),
                          CustomUserTextField(
                            controller:
                                context.read<AuthCubit>().passwordController,
                            labelText: "Password",
                            isPassword: true,
                            suffixIcon: Icon(
                              Icons.lock,
                              color: Colors.white54,
                              size: 18,
                            ),
                          ),
                          const Gap(24),
                          BlocBuilder<AuthCubit, AuthStates>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;
                              return isLoading
                                  ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                  : CustomAuthBtn(
                                    onTap: () => _submit(context),
                                    text: "Sign Up",
                                    color: AppColors.primary,
                                    fontsize: 20,
                                    fontweight: FontWeight.w600,
                                    height: 50,
                                    width: double.infinity,
                                    backgroundColor: Colors.white,
                                  );
                            },
                          ),
                          const Gap(16),

                          SizedBox(
                            height: 50,
                            child: CustomAuthBtn(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => const LoginView(),
                                  ),
                                  (route) => false,
                                );
                              },
                              text: "back to login",
                              textColor: Colors.black,
                              color: AppColors.primary,
                              fontsize: 20,
                              fontweight: FontWeight.w600,
                              height: 50,
                              width: double.infinity,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
