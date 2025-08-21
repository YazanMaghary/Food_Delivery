import 'package:ecommerce_app/core/constant/images_constances.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/widgets/base_widget.dart';
import 'package:ecommerce_app/features/start_up/presentation/controllers/splash_controller.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  Animation<double>? _animation2;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.bounceOut),
    );
    _animation2 = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.bounceOut),
    );
    Future.delayed(const Duration(seconds: 3), () async {
      await ref.read(appStartDesProvider.future).then((des) {
        AppLogger.logger.i("Des $des");
        switch (des) {
          case AppStartDestination.onboarding:
            context.pushReplacementNamed(RoutersNames.onboarding);
            break;
          case AppStartDestination.login:
            context.pushReplacementNamed(RoutersNames.login);
            break;
          case AppStartDestination.noInternetConncetion:
            context.pushReplacementNamed(RoutersNames.noInternetConncetion);
          //add one for home based in user token
          case AppStartDestination.home:
            context.pushReplacementNamed(RoutersNames.home);
          case AppStartDestination.emailVerfication:
            context.pushReplacementNamed(RoutersNames.emailVerfication);
          case AppStartDestination.locationPermission:
            context.pushReplacementNamed(RoutersNames.locationPermission);
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(AppImagesConstances.splashScreenTopEl),
          ),
          AnimatedBuilder(
            animation: _animationController!,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                child: Transform.translate(
                  offset: Offset(0, _animation2!.value),
                  child: child,
                ),
                scale: _animation!.value,
              );
            },
            child: Center(child: Image.asset(AppImagesConstances.splashScreen)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AppImagesConstances.splashScreenDownEl),
          ),
        ],
      ),
    );
  }
}
