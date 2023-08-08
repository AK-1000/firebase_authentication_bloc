import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<bool> obscureTextVN;
  final String hintText;
  final void Function(String) onChanged;
  final void Function() onEditingComplete;

  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.obscureTextVN,
    required this.hintText,
    required this.onChanged,
    required this.onEditingComplete,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.obscureTextVN,
      builder: (BuildContext context, bool obscureText, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.ten),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  widget.obscureTextVN.value = !widget.obscureTextVN.value;
                },
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            obscureText: obscureText,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
          ),
        );
      },
    );
  }
}
