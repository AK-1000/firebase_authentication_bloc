import 'package:firebase_authentication_bloc/common_widgets/passwordTextField/password_cubit.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPasswordTextField extends StatelessWidget {
  final String hintText;
  final void Function(String) onChanged;

  const BlocPasswordTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: BlocBuilder<PasswordCubit, PasswordState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.ten),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.ten),
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<PasswordCubit>().toggleStatus();
                  },
                  child: Icon(
                    state.status == PasswordStatus.obscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText:
                  state.status == PasswordStatus.obscure ? true : false,
              onChanged: onChanged,
            ),
          );
        },
      ),
    );
  }
}
