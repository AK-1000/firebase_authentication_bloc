import 'package:firebase_authentication_bloc/common_widgets/login_page_widgets/custom_material_button.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/auth_form_cubit/authentication_form_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPasswordReset extends StatelessWidget {
  const BlocPasswordReset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (_) => ResetPasswordCubit(context.read<AuthRepository>()),
      child: WillPopScope(
        onWillPop: () => onBackPressed(context),
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context
                  .read<AuthenticationFormCubit>()
                  .toggleForm(FormType.signIn),
            ),
            backgroundColor: Colors.black,
            title: const Text(
              'Password Reset',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.fifty),
                // logo
                Icon(
                  Icons.privacy_tip_outlined,
                  size: Dimensions.hundred,
                ),
                SizedBox(height: Dimensions.fifty),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
                  child: Text(
                    "If you've lost your password or wish to reset it,"
                    " enter a valid email below",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: Dimensions.ten * 1.8,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.ten),
                const _EmailAddressTextField(),
                SizedBox(height: Dimensions.fifteen),
                BlocBuilder<ResetPasswordCubit,ResetPasswordState>(
                  buildWhen: (previous, current) => previous.status != current.status,
                  builder: (context,state) {
                    return CustomMaterialButton(
                      text: "Reset your password",
                      onTap: () => context
                          .read<ResetPasswordCubit>()
                          .resetPasswordSubmitted(),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed(BuildContext context) async {
    // Navigate to the previous screen
    context.read<AuthenticationFormCubit>().toggleForm(FormType.signIn);
    // Return false to prevent the back button from being pressed
    return false;
  }
}
class _EmailAddressTextField extends StatelessWidget {
  const _EmailAddressTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit,ResetPasswordState>(
      buildWhen: (previous,current) => previous.email != current.email,
      builder: (context,state) {
        return Padding(
          padding:
          EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
          child: TextField(
            autocorrect: true,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey[500])),
            onChanged: (email) {
              context.read<ResetPasswordCubit>().emailChanged(email);
            },
          ),
        );
      }
    );
  }
}

