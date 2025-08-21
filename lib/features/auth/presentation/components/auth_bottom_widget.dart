import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBottomWidget extends StatelessWidget {
  const AuthBottomWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        padding: EdgeInsets.only(left: 24.w ,right: 24.w,top: 24.h),
        decoration: BoxDecoration(
          color: AppColorsConstances.scaffoldBackgroundColorLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: child,
      ),
    );
  }
}
