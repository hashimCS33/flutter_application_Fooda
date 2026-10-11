import 'package:flutter/material.dart';
import 'package:flutter_application_hungray/Core/Constanst/app_Colors.dart';
import 'package:flutter_application_hungray/Features/auth/cubit/profile_cubit.dart';
import 'package:flutter_application_hungray/Features/auth/data/user_model.dart';
import 'package:flutter_application_hungray/shared/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = context.select<ProfileCubit, String?>(
      (c) => c.state.user?.imageUrl,
    );
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Hello, ${context.select<ProfileCubit, String?>((c) => c.state.user?.name) ?? 'User'}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomText(
                text: "Hungray right now ".toUpperCase(),
                color: Colors.grey,
                fontweight: FontWeight.w500,
                fontsize: 20,
              ),
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 33),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Container(
                  color: Colors.grey.shade300,
                  child:
                      (imageUrl != null && imageUrl.isNotEmpty)
                          ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder:
                                (context, error, builder) => Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                          )
                          : Icon(
                            Icons.person,
                            size: 60,
                            color: const Color.fromARGB(255, 250, 249, 249),
                          ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
