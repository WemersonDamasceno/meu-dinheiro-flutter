import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowCase extends StatelessWidget {
  const CustomShowCase({
    Key? key,
    required this.child,
    required this.title,
    required this.description,
    required this.keyGlobal,
    required this.isShowCase,
  }) : super(key: key);
  final Widget child;
  final String title;
  final String description;
  final GlobalKey keyGlobal;
  final bool isShowCase;

  @override
  Widget build(BuildContext context) {
    return isShowCase
        ? Showcase(
            title: title,
            key: keyGlobal,
            child: child,
            description: description,
          )
        : child;
  }
}
