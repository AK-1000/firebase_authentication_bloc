import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';

class UserInfoTextField extends StatefulWidget {
  UserInfoTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.focusNode,
    required this.validator,
    required this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.enabled = true,
    this.onSubmitted,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  final bool enabled;

  @override
  State<UserInfoTextField> createState() => _UserInfoTextFieldState();
}

class _UserInfoTextFieldState extends State<UserInfoTextField> {
  TextEditingController get controller => widget.controller;

  FocusNode get focusNode => widget.focusNode;

  String get labelText => widget.labelText;

  IconData get prefixIcon => widget.prefixIcon;

  String? Function(String?)? get validator => widget.validator;

  Widget? get suffixIcon => widget.suffixIcon;

  TextInputType? get keyboardType => widget.keyboardType;

  TextInputAction get textInputAction => widget.textInputAction;

  VoidCallback? get onSubmitted => widget.onSubmitted;

  bool get enabled => widget.enabled;
  late ValueNotifier<Color> _textFieldColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.five),
      child: Container(
        child: ValueListenableBuilder<Color>(
          valueListenable: _textFieldColor,
          builder: (context, color, _) => Focus(
            focusNode: focusNode,
            child: Stack(alignment: Alignment.centerRight, children: [
              TextFormField(
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: enabled ? color : Colors.grey[900],
                ),
                enabled: enabled,
                controller: controller,
                decoration: InputDecoration(
                  fillColor: enabled ? Colors.grey.shade200 : Colors.grey[400],
                  filled: true,
                  label: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Text(
                            labelText,
                            style: TextStyle(
                              color: enabled ? color : Colors.grey[800],
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
                    color: enabled ? color : Colors.grey[800],
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
                validator: validator,
                onEditingComplete: onSubmitted,
              ),
              if (suffixIcon != null)
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
                        suffixIcon!,
                      ],
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _textFieldColor = ValueNotifier<Color>(Colors.grey.shade600);
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (focusNode.hasFocus) {
      _textFieldColor.value = Colors.black;
    } else {
      _textFieldColor.value = Colors.grey.shade600;
    }
  }
}
