import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/l10n/string_constances.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/core/widgets/main_button.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_bottom_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_top_widget.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerficationScreen extends StatelessWidget {
  VerficationScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).viewInsets.bottom;
    final user = FirebaseAuth.instance;
    return BaseScreen(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (MediaQuery.of(context).size.height > 500) {
                return authTopWidget(
                  mediaQuery: mediaQuery,
                  title: AppStringConstances.verfication,
                  subTitle: AppStringConstances.verficationsubTitle,
                  secTitle: "${user.currentUser?.email}",
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          //second
          AuthBottomWidget(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStringConstances.code,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppStringConstances.resend,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer:
                                    TapGestureRecognizer()..onTap = () {},
                              ),
                              const TextSpan(text: "\t\t"),
                              TextSpan(
                                text: "in sec",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSpacerConstances.smallSpacer8,
                    Pinput(
                      controller: controller,
                      closeKeyboardWhenCompleted: true,
                      enableIMEPersonalizedLearning: true,
                      enableSuggestions: true,
                      separatorBuilder: (index) {
                        return SizedBox(width: 26.w.clamp(0, 28));
                      },
                    ),
                  ],
                ),
                AppSpacerConstances.largeSpacer32,
                MainButton(text: AppStringConstances.verify),
                AppSpacerConstances.mediumSpaced16,
                InkWell(
                  child: Text(
                    AppStringConstances.returnToLogin,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColorsConstances.textColorMainBlack,
                    ),
                  ),
                  onTap: () async {
                    context.pushReplacementNamed(RoutersNames.login);
                    await user.signOut();
                  },
                ),
                AppSpacerConstances.smallSpacer8,
                InkWell(
                  child: Text(
                    AppStringConstances.clear,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onTap: () async {
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppColorsConstances.authBackGroundColor,
    );
  }
}
