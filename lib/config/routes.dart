import 'package:e_commerce_app/blocs/blocs.dart';
import 'package:e_commerce_app/screen/screens.dart';
import 'package:flutter/material.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [
        const MaterialPage<void>(child: HomeScreen()),
        /* const MaterialPage<void>(
            child: SplashScreen(
          widget: HomeScreen(),
        )), */
      ];
    case AppStatus.unauthenticated:
      return [
        const MaterialPage<void>(child: LoginScreen()),
        /* const MaterialPage<void>(
            child: SplashScreen(
          widget: LoginScreen(),
        )), */
      ];
    case AppStatus.unknown:
    default:
      return [
        const MaterialPage<void>(
            child: SplashScreen(
                /*  widget: LoginScreen(), */
                )),
      ];
  }
}
