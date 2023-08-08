import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, required this.size}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      const AssetImage('assets/logo/ak.png'),
      size: size,
    );
  }
}
