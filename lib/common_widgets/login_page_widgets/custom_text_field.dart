import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  //final InputDecoration decoration;
  final TextInputAction textInputAction;
  final void Function(String) onChanged;
  final void Function() onEditingComplete;
  final String hintText;
  final bool obscureText;
  final bool? autocorrect;
  final TextInputType? keyboardType;

  MyTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    //required this.decoration,
    required this.textInputAction,
    required this.onChanged,
    required this.onEditingComplete,
    required this.hintText,
    required this.obscureText,
    this.autocorrect = true,
    this.keyboardType = TextInputType.text,

  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.ten),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.ten),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])
        ),
        textInputAction: textInputAction,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
