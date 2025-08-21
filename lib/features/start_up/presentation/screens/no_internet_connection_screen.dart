import 'package:ecommerce_app/core/constant/images_constances.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';

class NoInternetConncetionScreen extends StatelessWidget {
  const NoInternetConncetionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesConstances.noWifi),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
