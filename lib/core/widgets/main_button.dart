import 'package:ecommerce_app/core/constant/app_colors_constances.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.onPressed,
    required this.text,
    this.suffixIcon,
    this.textKey,
  });
  final void Function()? onPressed;
  final String text;
  final Icon? suffixIcon;
  final Key? textKey;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Row(
          key: textKey,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(text,style: TextStyle(color: AppColorsConstances.textColorMainWhite),), suffixIcon ?? const SizedBox()],
        ),
      ),
    );
  }
}
