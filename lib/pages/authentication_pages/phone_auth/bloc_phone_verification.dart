import 'package:firebase_authentication_bloc/common_widgets/custom_loading_indicator.dart';
import 'package:firebase_authentication_bloc/common_widgets/phone_text_field.dart';
import 'package:firebase_authentication_bloc/common_widgets/user_detailsTextField.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPhoneVerification extends StatelessWidget {
  const BlocPhoneVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Phone Verification',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
          buildWhen: (previous, current) =>
              previous.formType != current.formType,
          builder: (context, state) {
            return state.formType == PhoneAuthFormType.phoneEntry
                ? _PhoneVerificationForm()
                : _SMSCodeForm();
          }),
    );
  }
}

class _PhoneVerificationForm extends StatelessWidget {
  _PhoneVerificationForm({Key? key}) : super(key: key);
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimensions.fifty),
          ImageIcon(
            const AssetImage('assets/logo/ak.png'),
            size: Dimensions.hundred * 1.5,
          ),
          SizedBox(height: Dimensions.thirty),
          //if (model.formType == PhoneVerificationFormType.verify)
          PhoneTextField(
            controller: _phoneController,
            //textInputAction: TextInputAction.done,
            //onEditingComplete: () => () {},
          ),
          SizedBox(height: Dimensions.thirty),

          BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
              builder: (context, state) {
            return state.isLoading
                // ? const CircularProgressIndicator()
                ? const ColoredProgressIndicator()
                : GestureDetector(
                    onTap: () {
                      context
                          .read<PhoneAuthCubit>()
                          .verifyPhone(_phoneController.text);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.twentyFive),
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.twentyFive),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(Dimensions.eight),
                      ),
                      child: Center(
                        child: Text(
                          "Verify Phone",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.ten * 1.6,
                          ),
                        ),
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}

class _SMSCodeForm extends StatelessWidget {
  _SMSCodeForm({Key? key}) : super(key: key);
  final TextEditingController _smsController = TextEditingController();
  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimensions.fifty),
          ImageIcon(
            const AssetImage('assets/logo/ak.png'),
            size: Dimensions.hundred * 1.5,
          ),
          SizedBox(height: Dimensions.thirty),
          //if (model.formType == PhoneVerificationFormType.verify)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.twentyFive),
            child: UserDetailsTextField(
              controller: _smsController,
              enabled: true,
              prefixIcon: Icons.new_releases_outlined,
              labelText: 'SMS Code/OTP',
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(height: Dimensions.thirty),

          BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
              builder: (context, state) {
            if (state.isDone) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              });

            }
            return state.isLoading
                ? const ColoredProgressIndicator()
                : GestureDetector(
                    onTap: () {
                      context
                          .read<PhoneAuthCubit>()
                          .verifySMSCode(_smsController.text);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.twentyFive),
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.twentyFive),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(Dimensions.eight),
                      ),
                      child: Center(
                        child: Text(
                          "Verify SMS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.ten * 1.6,
                          ),
                        ),
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
