import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:ecommerce_app/core/constant/app_spacer_constances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.suffixIcon,
  });
  final String label;
  final String hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        AppSpacerConstances.smallSpacer8,
        TextField(
          obscureText: obscureText ?? false,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            fillColor: AppColorsConstances.textFieldbackColor,
            filled: true,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColorsConstances.textColorMainGrey2,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ],
    );
  }
}
