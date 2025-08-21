import 'dart:math';
import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/constant/images_constances.dart';
import 'package:ecommerce_app/core/l10n/string_constances.dart';
import 'package:ecommerce_app/core/services/secure_cache.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/core/widgets/main_button.dart';
import 'package:ecommerce_app/features/start_up/data/models/onboarding_model.dart';
import 'package:ecommerce_app/features/start_up/presentation/controllers/onboarding_controller.dart';
import 'package:ecommerce_app/features/start_up/presentation/controllers/onboarding_sate.dart';
import 'package:ecommerce_app/routing/routers_names.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({super.key});

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      title: "Crave. Tap. Delivered.",
      description:
          "Explore curated dishes from your favorite chefs and have them brought straight to your door.",
      image: AppImagesConstances.firstOnboarding,
    ),
    OnboardingModel(
      title: "Real-Time Order Tracking",
      description:
          "Know exactly when your meal is being prepared, picked up, and delivered — minute by minute.",
      image: AppImagesConstances.secondOnboarding,
    ),
    OnboardingModel(
      title: "Choose Your Culinary Artist",
      description:
          "Order directly from handpicked chefs who match your taste and style. Personalized food, elevated.",
      image: AppImagesConstances.thirdOnboarding,
    ),
    OnboardingModel(
      title: "Flexible & Safe Checkout",
      description:
          "Multiple payment options, secure processing, and contactless delivery when you need it.",
      image: AppImagesConstances.fourthOnboarding,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controllerUi = ref.watch(onboardingControllerProvider);
    final _controller = ref.read(onboardingControllerProvider.notifier);
    return BaseScreen(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 10,
              child: PageView.builder(
                controller: _controllerUi.pageController,
                itemCount: onboardingList.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(onboardingList[index].image),
                          ),
                          border: Border.all(
                            color: AppColorsConstances.textColorMainBlack,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        width: min(240.w, 300),
                        height: min(280.h, 350),
                      ),
                      Column(
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            onboardingList[index].title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          AppSpacerConstances.mediumSpaced20,
                          Text(
                            textAlign: TextAlign.center,
                            onboardingList[index].description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            DotsIndicator(
              dotsCount: onboardingList.length,
              animate: true,
              decorator: DotsDecorator(
                size: const Size(10, 10),
                activeSize: const Size(12, 12),
                activeColor: AppColorsConstances.mainColor,
                color: AppColorsConstances.mainColorTrans,
              ),
              position: _controllerUi.currentPage ?? 0,
            ),
           AppSpacerConstances.largeSpacer40,

            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                    textKey: ValueKey(
                      _controllerUi.currentPage == onboardingList.length - 1,
                    ),

                    text:
                        _controllerUi.currentPage == onboardingList.length - 1
                            ? AppStringConstances.getStarted
                            : AppStringConstances.next,
                    onPressed: () async {
                      _controller.buttonDirect(onboardingList.length);
                      final button =
                          ref.read(onboardingControllerProvider).status;

                      switch (button) {
                        case buttonStatus.getStarted:
                        
                          await SecureStorageService().saveStateOfFirstTime(
                            "false",
                          );
                          context.pushReplacementNamed(RoutersNames.login);
                          break;
                        case buttonStatus.next:
                          _controller.nextPage(onboardingList.length);
                        default:
                      }
                    },
                  ),

                  _controllerUi.currentPage == onboardingList.length - 1
                      ? const SizedBox()
                      : InkWell(
                        child: Text(
                          AppStringConstances.skip,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onTap: () async {
                          await SecureStorageService().saveStateOfFirstTime(
                            "false",
                          );
                          context.pushReplacementNamed(RoutersNames.login);
                        },
                      ),
                ],
              ),
            ),
            AppSpacerConstances.mediumSpaced20,
          ],
        ),
      ),
    );
  }
}
