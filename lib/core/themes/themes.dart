
import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  Themes._();

  static ThemeData lightTheme() => ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColorsConstances.scaffoldBackgroundColorLight,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.sen(
        fontSize: 24.sp.clamp(16, 28),
        color: AppColorsConstances.textColorMainBlack,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: GoogleFonts.sen(
        fontSize: 30.sp.clamp(20, 34),
        color: AppColorsConstances.textColorMainBlack,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: GoogleFonts.sen(
        fontSize: 14.sp.clamp(6, 18),
        fontWeight: FontWeight.bold,
        color: AppColorsConstances.textColorMainWhite,
      ),
      bodyMedium: GoogleFonts.sen(
        fontSize: 16.sp.clamp(6, 20),
        color: AppColorsConstances.textColorMainGrey,
      ),
      bodySmall: GoogleFonts.sen(
        fontSize: 13.sp.clamp(6, 15),
        color: AppColorsConstances.textColorMainBlack,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColorsConstances.checkboxbordercolor),
        borderRadius: BorderRadius.circular(4.r),
      ),
      side: BorderSide(
        color: AppColorsConstances.checkboxbordercolor,
        width: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        // foregroundColor: AppColorsConstances.scaffoldBackgroundColorLight,
        fixedSize: Size(ScreenUtil.defaultSize.width, 62.h.clamp(45, 65)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColorsConstances.mainColor,
      ),
    ),
  );
  static ThemeData darkTheme() => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColorsConstances.scaffoldBackgroundColorDark,
  );
}
