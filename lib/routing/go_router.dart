import 'package:ecommerce_app/features/auth/presentation/screen/email_verfication_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/screen/forgot_password_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/screen/login_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/screen/signup_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/screen/verfication_screen.dart';
import 'package:ecommerce_app/features/home/presentation/screens/home.dart';
import 'package:ecommerce_app/features/start_up/presentation/screens/location_permission.dart';
import 'package:ecommerce_app/features/start_up/presentation/screens/no_internet_connection_screen.dart';
import 'package:ecommerce_app/features/start_up/presentation/screens/onboarding_screen.dart';
import 'package:ecommerce_app/features/start_up/presentation/screens/splash_screen.dart';
import 'package:ecommerce_app/routing/routers_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routers {
  Routers._();
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: RoutersNames.splash,
        path: "/",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SplashScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.login,
        path: "/login",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: LoginScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.onboarding,
        path: "/onboarding",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: OnboardingScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.forgotPass,
        path: "/forgotpass",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: ForgotPasswordScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.verfication,
        path: "/verfication",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: VerficationScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.emailVerfication,
        path: "/emailVerfication",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const EmailVerficationScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.signup,
        path: "/signup",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SignupScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.noInternetConncetion,
        path: "/noInternetConncetion",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const NoInternetConncetionScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        name: RoutersNames.home,
        path: "/home",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const HomeSceen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        name: RoutersNames.locationPermission,
        path: "/locationPermission",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const LocationPermissionScreen(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    ],
  );
  static GoRouter get router => _router;
}
