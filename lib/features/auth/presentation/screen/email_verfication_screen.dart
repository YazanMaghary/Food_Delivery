import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/l10n/string_constances.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/core/widgets/failure_toasted_widget.dart';
import 'package:ecommerce_app/core/widgets/main_button.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_bottom_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_top_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/controller/login/login_controller.dart';
import 'package:ecommerce_app/features/auth/presentation/controller/login/login_state.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmailVerficationScreen extends ConsumerWidget {
  const EmailVerficationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).viewInsets.bottom;
    final user = FirebaseAuth.instance;
    final controller = ref.read(loginControllerProvider.notifier);
    final interactiveController = ref.watch(loginControllerProvider);

    return BaseScreen(
      backgroundColor: AppColorsConstances.authBackGroundColor,
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
          AuthBottomWidget(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                    text: AppStringConstances.verfication,
                    onPressed:
                        interactiveController.value?.timerCheck == false
                            ? () {
                              ToastedWidget.failureToastedWidget(
                                "Wait ${interactiveController.value?.timer} sec For another request ",
                              );
                            }
                            : () async {
                              await user.currentUser?.reload();
                              await controller.sendEmailVerification().then((
                                des,
                              ) {
                                switch (des) {
                                  case VerficationState.loading:
                                    AppLogger.logger.i(
                                      "Email Verification is loading",
                                    );
                                  case VerficationState.completed:
                                    context.pushReplacementNamed(
                                      RoutersNames.home,
                                    );
                                  case VerficationState.error:
                                    AppLogger.logger.e(
                                      "Error in Verfication email try again after 60 seconds",
                                    );
                                  case VerficationState.verficationRequested:
                                    AppLogger.logger.f(
                                      "Email Verification already requested, please wait 60 seconds",
                                    );

                                  default:
                                }
                              });
                              await controller.timer();
                            },
                  ),
                  AppSpacerConstances.mediumSpaced16,
                  Text(
                    '${interactiveController.value?.timer ?? "60"} for another request',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
