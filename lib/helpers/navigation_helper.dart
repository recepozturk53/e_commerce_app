import 'package:e_commerce_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static late BuildContext _context;

  static void initialize(BuildContext context) {
    _context = context;
  }

  static void navigateToHomeScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
