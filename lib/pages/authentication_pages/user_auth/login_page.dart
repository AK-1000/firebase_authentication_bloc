import 'package:firebase_authentication_bloc/common_widgets/app_logo.dart';
import 'package:firebase_authentication_bloc/common_widgets/custom_loading_indicator.dart';
import 'package:firebase_authentication_bloc/common_widgets/login_page_widgets/SquareTile.dart';
import 'package:firebase_authentication_bloc/common_widgets/login_page_widgets/custom_login_button.dart';
import 'package:firebase_authentication_bloc/common_widgets/passwordTextField/passwordTextField.dart';
import 'package:firebase_authentication_bloc/common_widgets/platform_alert_dialogs.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/auth_form_cubit/authentication_form_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/login_cubit/login_cubit.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BlocLoginForm extends StatelessWidget {
  const BlocLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.fifty),
                  // logo
                  AppLogo(size: Dimensions.hundred * 2),

                  SizedBox(height: Dimensions.fifty),

                  // welcome back, you've been missed!
                  Text(
                    'Sign in using your email address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: Dimensions.ten * 1.6,
                    ),
                  ),

                  SizedBox(height: Dimensions.twentyFive),

                  // email text-field
                  const _EmailTextField(),

                  SizedBox(height: Dimensions.ten),

                  const _PasswordTextField(),

                  SizedBox(height: Dimensions.ten),

                  const _ResetPasswordText(),

                  SizedBox(height: Dimensions.twentyFive),

                  // sign in button
                  const _LoginButton(),

                  SizedBox(height: Dimensions.twenty),

                  const _ContinueUsingGoogleText(),

                  SizedBox(height: Dimensions.twenty),

                  const _GoogleSignInButton(),

                  SizedBox(height: Dimensions.thirty),

                  const _SignUpToggleText(),

                  //const _SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
          child: TextField(
            //errorText: "Email is empty",
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.ten),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.ten),
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[500])),
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (email) {
              context.read<LoginCubit>().emailChanged(email);
            },
          ),
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return BlocPasswordTextField(
          //errorText: "Email is empty",
          hintText: 'Password',
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _ResetPasswordText extends StatelessWidget {
  const _ResetPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.grey[600]),
            ),
            onTap: () {
              context
                  .read<AuthenticationFormCubit>()
                  .toggleForm(FormType.resetPassword);
            },
          ),
        ],
      ),
    );
  }
}

class _ContinueUsingGoogleText extends StatelessWidget {
  const _ContinueUsingGoogleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: Dimensions.one * .5,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.ten),
            child: Text(
              'Or continue with',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: Dimensions.one * .5,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<LoginCubit>().logInWithGoogle();
            },
            child: const SquareTile(imagePath: 'assets/image/google.png'),
          );
        });
  }
}

class _SignUpToggleText extends StatelessWidget {
  const _SignUpToggleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member?',
          style: TextStyle(color: Colors.grey[700]),
        ),
        SizedBox(width: Dimensions.one * 4),
        GestureDetector(
          onTap: () {
            context.read<AuthenticationFormCubit>().toggleForm(FormType.signUp);
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const ColoredProgressIndicator()
            : CustomButton(
                text: 'Log in',
                onTap: () {
                  context.read<LoginCubit>().logInWithCredential();
                },
              );
      },
    );
  }
}
