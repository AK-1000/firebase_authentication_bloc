import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const CustomMaterialButton(
      {super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(
          Dimensions.ten,
        ),
        child: MaterialButton(
          minWidth: double.infinity,
          height: Dimensions.seventy,
          child: Text(
            "$text",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.ten * 1.6,
            ),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
