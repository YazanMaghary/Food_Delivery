import 'dart:convert';

import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:ecommerce_app/core/constant/images_constances.dart';
import 'package:ecommerce_app/core/l10n/string_constances.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/services/secure_cache.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/core/widgets/failure_toasted_widget.dart';
import 'package:ecommerce_app/core/widgets/main_button.dart';
import 'package:ecommerce_app/features/start_up/domain/provider/use_case_prvider.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200.w.clamp(150, 220),
              height: 250.h.clamp(200, 270),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90.r),
                image: DecorationImage(
                  image: AssetImage(AppImagesConstances.location),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            AppSpacerConstances.largeSpacer60,
            AppSpacerConstances.largeSpacer32,
            MainButton(
              text: AppStringConstances.accesslocation,
              suffixIcon: Icon(
                Icons.location_on_outlined,
                size: 16.sp.clamp(12, 20),
                color: AppColorsConstances.textColorMainWhite,
              ),
              onPressed: () async {
                final location = await ref.read(locationUseCaseProvider).call();

                location.fold(
                  (l) {
                    ToastedWidget.failureToastedWidget(
                      "Error getting location: $l",
                    );
                  },
                  (r) async {
                    final city = await placemarkFromCoordinates(
                      r.latitude,
                      r.longitude,
                    );
                    SecureStorageService().saveUserAddress(json.encode(city));
                    AppLogger.logger.i("User Location: ${city}");
                    context.pushReplacementNamed(RoutersNames.home);
                  },
                );
              },
            ),

            AppSpacerConstances.largeSpacer32,
            Text(
              "DFOOD WILL ACCESS YOUR LOCATION ONLY WHILE USING THE APP",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      backgroundColor: AppColorsConstances.scaffoldBackgroundColorLight,
    );
  }
}
