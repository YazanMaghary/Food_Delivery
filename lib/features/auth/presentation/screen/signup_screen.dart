import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/l10n/string_constances.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/main_button.dart';
import 'package:ecommerce_app/features/auth/data/model/auth_state.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_bottom_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_top_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/controller/signup/signup_controller.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).viewInsets.bottom;
    final controller = ref.read(signupControllerProvider.notifier);
    final interaciveController = ref.watch(signupControllerProvider);

    return GestureDetector(
      onTap: () {
        //unFocucus all focuse nodes
      },
      child: BaseScreen(
        backgroundColor: AppColorsConstances.authBackGroundColor,
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (MediaQuery.of(context).size.height > 500) {
                  return authTopWidget(
                    mediaQuery: mediaQuery,
                    title: AppStringConstances.signup,
                    subTitle: AppStringConstances.signupsubTitle,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            AuthBottomWidget(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      label: AppStringConstances.name,
                      hintText: "YazanM",
                      onChanged: (p0) {},
                    ),

                    AppSpacerConstances.mediumSpaced24,
                    CustomTextField(
                      controller: controller.emailController,
                      label: AppStringConstances.email,
                      hintText: "example@gmail.com",
                      onChanged: (p0) {},
                    ),
                    AppSpacerConstances.mediumSpaced24,
                    CustomTextField(
                      obscureText:
                          interaciveController.value?.checkPasswordVis == true
                              ? false
                              : true,
                      controller: controller.passwordController,
                      label: AppStringConstances.password,
                      suffixIcon: IconButton(
                        onPressed: controller.checkVisiabiltiyState,
                        icon: Icon(
                          interaciveController.value?.checkPasswordVis == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColorsConstances.iconMainGrey3,
                        ),
                      ),
                      hintText: "******",
                      onChanged: (p0) {},
                    ),
                    AppSpacerConstances.mediumSpaced24,
                    CustomTextField(
                      obscureText:
                          interaciveController.value?.checkRetypePasswordVis ==
                                  true
                              ? false
                              : true,
                      controller: controller.retypepasswordController,
                      label: AppStringConstances.retypepassword,
                      suffixIcon: IconButton(
                        onPressed: controller.checkVisiabiltiyState2,
                        icon: Icon(
                          interaciveController.value?.checkRetypePasswordVis ==
                                  true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColorsConstances.iconMainGrey3,
                        ),
                      ),
                      hintText: "******",
                      onChanged: (p0) {},
                    ),
                    AppSpacerConstances.largeSpacer40,
                    interaciveController.value?.signUpStatus ==
                            AuthState.loading
                        ? const CircularProgressIndicator()
                        : MainButton(
                          text: AppStringConstances.signup.toUpperCase(),
                          onPressed:
                              interaciveController.value?.signUpStatus ==
                                      AuthState.loading
                                  ? () {}
                                  : () async {
                                    controller.signupValidation();
                                    await controller.signup().then((status) {
                                      switch (status) {
                                        case AuthState.loading:
                                          AppLogger.logger.i("Loading");
                                        case AuthState.complete:
                                          context.pushReplacementNamed(
                                            RoutersNames.login,
                                          );
                                          AppLogger.logger.i("Completed");
                                        case AuthState.error:
                                          AppLogger.logger.i("Error");
                                        default:
                                          AppLogger.logger.i("Still Loading");
                                      }
                                    });
                                  },
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
