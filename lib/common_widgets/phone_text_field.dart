import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    required this.controller,
    //required this.onChanged,
    //required this.onEditingComplete,
  }) : super(key: key);
  final TextEditingController controller;
  //final void Function(String) onChanged;
  //final void Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
      child: InternationalPhoneNumberInput(
        onInputChanged: (number) {
          String formattedNumber = '${number.phoneNumber}';
          controller.text = formattedNumber;
          //onChanged(formattedNumber);
          // Do something with the phone number
        },
        selectorTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ignoreBlank: false,
        selectorConfig: SelectorConfig(
          setSelectorButtonAsPrefixIcon: true,
          selectorType: PhoneInputSelectorType.DIALOG,
         // backgroundColor: Colors.white,
          showFlags: true,
          leadingPadding: Dimensions.fifteen,
          useEmoji: true,
        ),
        inputDecoration: InputDecoration(
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
            hintText: "Phone Number",
            hintStyle: TextStyle(color: Colors.grey[500])
        ),
      ),
    );
  }
}
