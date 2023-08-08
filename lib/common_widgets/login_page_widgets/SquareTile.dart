import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.twenty),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(Dimensions.one * 16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: Dimensions.forty,
      ),
    );
  }
}