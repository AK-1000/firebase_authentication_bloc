import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.textInputAction,
    this.keyboardType = TextInputType.text,
    required this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final Widget suffixIcon;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.five),
      child: Stack(alignment: Alignment.centerRight, children: [
        TextFormField(
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
          enabled: false,
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.grey[400],
            filled: true,
            label: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Text(
                      labelText,
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  const WidgetSpan(
                    child: Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey[800],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade600,
              ),
              borderRadius: BorderRadius.circular(Dimensions.ten),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade600,
              ),
              borderRadius: BorderRadius.circular(Dimensions.ten),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(Dimensions.ten),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.red),
              borderRadius: BorderRadius.circular(Dimensions.ten),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.red),
              borderRadius: BorderRadius.circular(Dimensions.ten),
            ),
          ),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
        ),
        Positioned(
          right: Dimensions.one,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.ten),
                bottomRight: Radius.circular(Dimensions.ten),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: Dimensions.ten * 1.8 * 3,
                  width: Dimensions.one,
                  color: Colors.black, // Customize the color as needed
                ),
                suffixIcon,
              ],
            ),
          ),
        )
      ]),
    );
  }
}
