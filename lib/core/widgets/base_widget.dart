import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const BaseScreen({required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: child, backgroundColor: backgroundColor),
    );
  }
}
