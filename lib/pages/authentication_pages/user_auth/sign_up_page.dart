import 'package:firebase_authentication_bloc/common_widgets/app_logo.dart';
import 'package:firebase_authentication_bloc/common_widgets/custom_loading_indicator.dart';
import 'package:firebase_authentication_bloc/common_widgets/login_page_widgets/custom_login_button.dart';
import 'package:firebase_authentication_bloc/common_widgets/passwordTextField/passwordTextField.dart';
import 'package:firebase_authentication_bloc/common_widgets/platform_alert_dialogs.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/auth_form_cubit/authentication_form_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocSignUpScreen extends StatelessWidget {
  const BlocSignUpScreen({Key? key}) : super(key: key);
  static Route route(){
    return MaterialPageRoute<void>(builder: (_) => const BlocSignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(context.read<AuthRepository>()),
      child: WillPopScope(
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

                    SizedBox(height: Dimensions.ten),

                    const _DisplayNameTextField(),

                    SizedBox(height: Dimensions.ten),

                    // email text field
                    const _EmailTextField(),

                    SizedBox(height: Dimensions.ten),

                    const _PasswordTextField(),

                    SizedBox(height: Dimensions.ten),

                    const _ConfirmPasswordTextField(),

                    SizedBox(height: Dimensions.twentyFive),

                    // sign up button
                    const _RegisterButton(),

                    SizedBox(height: Dimensions.twenty),

                    const _SignInToggleText(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DisplayNameTextField extends StatelessWidget {
  const _DisplayNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.displayName != current.displayName,
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
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.grey[500])),
            autocorrect: false,
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (displayName) {
              context.read<SignUpCubit>().displayNameChanged(displayName);
            },
          ),
        );
      },
    );
  }
}


class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
              context.read<SignUpCubit>().emailChanged(email);
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return BlocPasswordTextField(
          //errorText: "Email is empty",
          hintText: 'Password',
          onChanged: (password) {
            context.read<SignUpCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  const _ConfirmPasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return BlocPasswordTextField(
          //errorText: "Email is empty",
          hintText: 'Confirm Password',
          onChanged: (confirmPassword) {
            context.read<SignUpCubit>().confirmPasswordChanged(confirmPassword);
          },
        );
      },
    );
  }
}


class _RegisterButton extends StatelessWidget {
  const _RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignUpStatus.submitting
            ? const ColoredProgressIndicator()
            : CustomButton(
          text: 'Sign Up',
          onTap: () {
            context.read<SignUpCubit>().signUpFormSubmitted();
          },
        );
      },
    );
  }
}

class _SignInToggleText extends StatelessWidget {
  const _SignInToggleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?',
          style: TextStyle(color: Colors.grey[700]),
        ),
        SizedBox(width: Dimensions.one * 4),
        GestureDetector(
          onTap: () {
            context.read<AuthenticationFormCubit>().toggleForm(FormType.signIn);
          },
          child: const Text(
            'Sign In',
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
