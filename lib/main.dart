import 'package:ecommerce_app/core/services/init.dart';
import 'package:ecommerce_app/core/themes/themes.dart';
import 'package:ecommerce_app/routing/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await Init().initSetup();
  runApp(
    const ProviderScope(
      child: ScreenUtilInit(
        designSize: Size(375, 812), 
        child: MyApp(), // iPhone 12 Pro design size
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routers.router,
      theme: Themes.lightTheme(),
    );
  }
}
