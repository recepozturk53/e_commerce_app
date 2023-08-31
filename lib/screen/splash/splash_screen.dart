import 'dart:async';

import 'package:e_commerce_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: const AssetImage(
                'assets/images/Logo.png',
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFF9900),
              borderRadius: BorderRadius.circular(12),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              'AZAMONBUCKS',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
