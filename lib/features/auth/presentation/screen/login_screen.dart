import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/l10n/string_constances.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/failure_toasted_widget.dart';
import 'package:ecommerce_app/core/widgets/main_button.dart';
import 'package:ecommerce_app/features/auth/data/model/auth_state.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_bottom_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/components/auth_top_widget.dart';
import 'package:ecommerce_app/features/auth/presentation/controller/login/login_controller.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context).viewInsets.bottom;
    final controller = ref.read(loginControllerProvider.notifier);
    final interaciveController = ref.watch(loginControllerProvider);
    return GestureDetector(
      onTap: controller.unFocusKeyboard,
      child: BaseScreen(
        backgroundColor: AppColorsConstances.authBackGroundColor,
        child: Column(
          children: [
            //first
            LayoutBuilder(
              builder: (context, constraints) {
                if (MediaQuery.of(context).size.height > 500) {
                  return authTopWidget(
                    mediaQuery: mediaQuery,
                    title: AppStringConstances.login,
                    subTitle: AppStringConstances.loginsubTitle,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            //second
            AuthBottomWidget(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomTextField(
                      hintText: "example@gmail",
                      label: AppStringConstances.email,
                      controller: controller.emailController,
                      focusNode: controller.firstNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    AppSpacerConstances.mediumSpaced24,
                    CustomTextField(
                      hintText: "*******",
                      obscureText:
                          interaciveController.value?.checkPasswordVis == true
                              ? false
                              : true,
                      suffixIcon: IconButton(
                        onPressed: controller.checkVisiabiltiyState,
                        icon: Icon(
                          interaciveController.value?.checkPasswordVis == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColorsConstances.iconMainGrey3,
                        ),
                      ),
                      label: AppStringConstances.password,
                      onSubmitted: (p0) {},
                      controller: controller.passwordController,
                      focusNode: controller.secondNode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    AppSpacerConstances.mediumSpaced24,
                    //remmeber
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value:
                                  interaciveController.value?.checkBoxState ??
                                  false,
                              onChanged: (value) {
                                controller.checkBoxStateChanged(value!);
                              },
                            ),

                            Text(
                              AppStringConstances.remmeberme,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: AppColorsConstances.textColorMainGrey3,
                              ),
                            ),
                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(RoutersNames.forgotPass);
                            },
                            child: Text(
                              AppStringConstances.forgotPassword,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: AppColorsConstances.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        AppSpacerConstances.largeSpacer32,
                        interaciveController.value?.loginState ==
                                AuthState.loading
                            ? const CircularProgressIndicator()
                            : MainButton(
                              text: AppStringConstances.login,
                              onPressed: () async {
                                controller.unFocusKeyboard();
                                final bool serviceEnabled =
                                    await Geolocator.isLocationServiceEnabled();

                                await controller
                                    .loginUsingEmailAndPassword()
                                    .then((des) async {
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      switch (des.$1) {
                                        case AuthState.complete:
                                          Fluttertoast.showToast(msg: des.$2!);
                                          ToastedWidget.successToastedWidget(
                                            des.$2 ??
                                                "Successfully Logged In 😊",
                                          );

                                          if (user!.emailVerified) {
                                            if (serviceEnabled) {
                                              if (await Permission
                                                      .location
                                                      .isGranted ||
                                                  await Permission
                                                      .location
                                                      .isRestricted ||
                                                  await Permission
                                                      .location
                                                      .isLimited) {
                                                context.pushReplacementNamed(
                                                  RoutersNames.home,
                                                );
                                              } else {
                                                context.pushNamed(
                                                  RoutersNames
                                                      .locationPermission,
                                                );
                                              }
                                            } else {
                                              context.pushNamed(
                                                RoutersNames.locationPermission,
                                              );
                                            }
                                          } else {
                                            context.pushNamed(
                                              RoutersNames.emailVerfication,
                                            );
                                          }
                                        case AuthState.error:
                                          AppLogger.logger.e("Error");
                                          ToastedWidget.failureToastedWidget(
                                            des.$2 ?? "Unknown Error",
                                          );
                                        default:
                                          AppLogger.logger.i("Still Loading");
                                      }
                                    });
                              },
                            ),
                        AppSpacerConstances.largeSpacer40,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${AppStringConstances.haveanacc}\t",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text:
                                    "\t${AppStringConstances.signup}"
                                        .toUpperCase(),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: AppColorsConstances.mainColor,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pushNamed(RoutersNames.signup);
                                      },
                              ),
                            ],
                          ),
                        ),
                        AppSpacerConstances.largeSpacer32,
                        Text(
                          "${AppStringConstances.or}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppColorsConstances.textColorMainGrey,
                          ),
                        ),
                        AppSpacerConstances.mediumSpaced16,

                        IconButton(
                          onPressed:
                              interaciveController.value?.loginState ==
                                      AuthState.loading
                                  ? () {}
                                  : () async {
                                    await controller.logingUsingFacebook().then(
                                      (des) {
                                        switch (des) {
                                          case AuthState.loading:
                                            AppLogger.logger.i("Loading");
                                          case AuthState.complete:
                                            AppLogger.logger.i("Completed");
                                          case AuthState.error:
                                            AppLogger.logger.e("Error");
                                          default:
                                            AppLogger.logger.i("Still Loading");
                                        }
                                      },
                                    );
                                  },
                          icon: Icon(
                            Icons.facebook_sharp,
                            color: AppColorsConstances.blueColor,
                            size: 62.sp.clamp(48, 65),
                          ),
                        ),
                      ],
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
