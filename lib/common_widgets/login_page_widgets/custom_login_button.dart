import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const CustomButton({super.key,required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.twentyFive),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(Dimensions.eight),
        ),
        child:  Center(
          child: Text(
            "$text",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.ten *1.6,
            ),
          ),
        ),
      ),
    );
  }
}