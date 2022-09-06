import 'dart:developer';

import 'package:finances/app/presentation/features/home/home_page.dart';
import 'package:finances/app/presentation/features/login/login_page.dart';
import 'package:finances/app/presentation/features/splash/splash.dart';
import 'package:finances/core/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu dinheiro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: ShowCaseWidget(
          onStart: (index, key) => log('onStart: $index, $key'),
          onComplete: (index, key) {
            log('onComplete: $index, $key');
            SharedPref().save("showcase", true);
          },
          blurValue: 1,
          builder: Builder(builder: (context) => const HomePage()),
          // autoPlayDelay: const Duration(seconds: 3),
          // autoPlay: true,
        ),
      ),
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
