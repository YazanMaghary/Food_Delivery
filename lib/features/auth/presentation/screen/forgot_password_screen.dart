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
import 'package:ecommerce_app/features/auth/presentation/controller/login/login_controller.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).viewInsets.bottom;
    final controller = ref.read(loginControllerProvider.notifier);
    final interactivController = ref.watch(loginControllerProvider);
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: BaseScreen(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (MediaQuery.of(context).size.height > 500) {
                  return authTopWidget(
                    mediaQuery: mediaQuery,
                    title: AppStringConstances.forgotPassword,
                    subTitle: AppStringConstances.loginsubTitle,
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
                  CustomTextField(controller: controller.emailController,
                    label: AppStringConstances.email,
                    hintText: "example@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    focusNode: focusNode,
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      //when press done
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  AppSpacerConstances.largeSpacer32,
                  interactivController.value?.loginState == AuthState.loading
                      ? const CircularProgressIndicator()
                      : MainButton(
                        text: AppStringConstances.sendCode,
                        onPressed: () async {
                          await controller.resetPassword().then((des) {
                            switch (des) {
                              case AuthState.loading:
                                AppLogger.logger.i("Still loading");
                                break;
                              case AuthState.error:
                                AppLogger.logger.e("Error occurred");
                                break;
                              case AuthState.complete:
                                AppLogger.logger.i("Password reset email sent");
                                context.pushReplacementNamed(
                                  RoutersNames.login,
                                );
                                break;
                            }
                          });
                        },
                      ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColorsConstances.authBackGroundColor,
      ),
    );
  }
}
