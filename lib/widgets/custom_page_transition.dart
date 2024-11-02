import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;

  CustomPageRoute({
    required this.page,
    this.transitionDuration = const Duration(milliseconds: 800),
    this.reverseTransitionDuration = const Duration(milliseconds: 800),
    required Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transitionsBuilder,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: transitionDuration,
    reverseTransitionDuration: reverseTransitionDuration,
    transitionsBuilder: transitionsBuilder,
  );
}
