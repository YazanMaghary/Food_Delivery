import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/services/secure_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@riverpod
Future<AppStartDestination> appStartDes(Ref ref) async {
  final value = await SecureStorageService().readStateOfFirstTime();
  final firstTime = value == "false" ? false : true;
  final bool result = await InternetConnection().hasInternetAccess;
  final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  AppStartDestination? des;
  AppLogger.logger.i("is First Time $firstTime");
  if (!result) {
    return AppStartDestination.noInternetConncetion;
  } else {
    if (firstTime == false) {
      return await SecureStorageService().readRemmeberMeState().then((
        value,
      ) async {
        final name = FirebaseAuth.instance.currentUser;

        if (value == true.toString()) {
          if (name != null && name.emailVerified) {
            AppLogger.logger.f("User Loged In ${name.email}");
            AppLogger.logger.f("User Loged In ${name.uid}");
            if (serviceEnabled) {
              if (await Permission.location.isGranted ||
                  await Permission.location.isRestricted ||
                  await Permission.location.isLimited) {
                des = AppStartDestination.home;
              } else {
                des = AppStartDestination.locationPermission;
              }
            } else {
              des = AppStartDestination.locationPermission;
            }

            return des!;
          } else if (name != null && !name.emailVerified) {
            AppLogger.logger.f("User Not Verified ${name.email}");
            AppLogger.logger.f("User Not Verified ${name.uid}");

            des = AppStartDestination.emailVerfication;
          } else {
            FirebaseAuth.instance.signOut();
            des = AppStartDestination.login;
          }
        } else {
          FirebaseAuth.instance.signOut();
          des = AppStartDestination.login;
        }
        return des!;
      });
    } else {
      des = AppStartDestination.onboarding;
    }
  }
  return des;
}

enum AppStartDestination {
  onboarding,
  login,
  emailVerfication,
  home,
  noInternetConncetion,
  locationPermission,
}
