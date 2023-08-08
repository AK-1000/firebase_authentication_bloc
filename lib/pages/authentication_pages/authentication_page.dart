import 'package:firebase_authentication_bloc/cubits/authentication_cubits/auth_form_cubit/authentication_form_cubit.dart';
import 'package:firebase_authentication_bloc/pages/authentication_pages/user_auth/login_page.dart';
import 'package:firebase_authentication_bloc/pages/authentication_pages/user_auth/password_reset_page.dart';
import 'package:firebase_authentication_bloc/pages/authentication_pages/user_auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationForm extends StatelessWidget {
  const AuthenticationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationFormCubit, AuthenticationFormState>(
      buildWhen: (previous, current) => previous.formType != current.formType,
      builder: (context, state) {
        switch (state.formType) {
          case FormType.signIn:
            return const BlocLoginForm();
          case FormType.signUp:
            return const BlocSignUpScreen();
          case FormType.resetPassword:
            return const BlocPasswordReset();
          default:
            return const BlocLoginForm();
        }
      },
    );
  }
}
