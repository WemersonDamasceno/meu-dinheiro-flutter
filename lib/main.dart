import 'package:finances/src/pages/home/home_page.dart';
import 'package:finances/src/pages/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      initialRoute: '/',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
