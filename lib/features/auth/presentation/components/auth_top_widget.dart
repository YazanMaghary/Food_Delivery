import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/constant/images_constances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class authTopWidget extends StatelessWidget {
  authTopWidget({
    super.key,
    required this.mediaQuery,
    required this.title,
    required this.subTitle,
    this.secTitle,
  });

  final double mediaQuery;
  final String title;
  final String subTitle;
  final String? secTitle;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child:
          mediaQuery > 0
              ? const SizedBox()
              : SizedBox(
                height: ScreenUtil().screenHeight * 0.25,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      child: Image.asset(AppImagesConstances.loginTopLeftEl),
                      top: -15,
                    ),
                    Positioned(
                      child: Image.asset(AppImagesConstances.loginTopRitghVc),
                      top: 0,
                      right: 0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: AppColorsConstances.textColorMainWhite,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: AppColorsConstances.textColorMainWhite,
                          ),
                        ),
                        Text(
                          secTitle??"",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: AppColorsConstances.textColorMainWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                       AppSpacerConstances.mediumSpaced16
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}
