import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/auth_cubit.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/auth_states.dart';
import 'package:flutter_application_hungray/Features/auth/view/signup_view.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_btn.dart';
import 'package:flutter_application_hungray/Features/auth/widgets/custom_user_text_filed.dart';
import 'package:flutter_application_hungray/root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Root()),
            (route) => false,
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  SvgPicture.asset(
                    "assets/logo/logo.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                    height: 58,
                  ),
                  const Gap(12),
                  const Text(
                    "Welcome Back, Discover The Fast Food",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF565656),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(40),

                  CustomUserTextField(
                    controller: cubit.emailController,
                    labelText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(14),
                  CustomUserTextField(
                    controller: cubit.passwordController,
                    labelText: "Password",
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const Gap(24),

                  BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomAuthBtn(
                        onTap: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.login(
                              cubit.emailController.text.trim(),
                              cubit.passwordController.text.trim(),
                            );
                          }
                        },
                        text: 'Login',
                        color: const Color.fromARGB(255, 246, 247, 247),
                        backgroundColor: AppColors.primary,
                        width: double.infinity,
                        height: 58,
                        isLoading: isLoading,
                      );
                    },
                  ),

                  const Gap(16),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CustomAuthBtn(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignupView(),
                                ),
                              );
                            },
                            text: 'Sign Up',
                            color: AppColors.primary,
                            fontsize: 20,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(14),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: CustomAuthBtn(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Root(),
                                ),
                                (route) => false,
                              );
                            },
                            text: 'Guest',
                            color: AppColors.primary,
                            fontsize: 20,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),

                  Lottie.asset(
                    'assets/animation/hamburger.json',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
