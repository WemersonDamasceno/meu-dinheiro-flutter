import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.popAndPushNamed(context, "/home");
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFF08148),
              Color(0xFFF96C25),
              Color(0xFFC70C0C),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * .8,
                  child: LottieBuilder.asset(
                    "assets/lottie/splash_animation.json",
                  ),
                ),
                const Text(
                  "Meu Dinheiro!",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
