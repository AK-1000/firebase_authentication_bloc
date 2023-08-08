import 'package:firebase_authentication_bloc/common_widgets/app_logo.dart';
import 'package:firebase_authentication_bloc/common_widgets/custom_loading_indicator.dart';
import 'package:firebase_authentication_bloc/common_widgets/login_page_widgets/custom_login_button.dart';
import 'package:firebase_authentication_bloc/common_widgets/user_detailsTextField.dart';
import 'package:firebase_authentication_bloc/common_widgets/user_profile/user_details_phone_text_field.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/user_details_cubit/user_details_cubit.dart';
import 'package:firebase_authentication_bloc/models/user_model.dart';
import 'package:firebase_authentication_bloc/pages/authentication_pages/phone_auth/bloc_phone_verification.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('User Info'),
          centerTitle: true,
          actions: const [
            _LogOutButton(),
          ],
        ),
        body: state.user == User.empty
            ? ColoredProgressIndicator(size: Dimensions.hundred)
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: const _BuildBodyContent(),
              ),
      );
    });
  }
}

class _BuildBodyContent extends StatefulWidget {
  const _BuildBodyContent({Key? key}) : super(key: key);

  @override
  State<_BuildBodyContent> createState() => _BuildBodyContentState();
}

class _BuildBodyContentState extends State<_BuildBodyContent> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController displayNameController = TextEditingController(),
        emailController = TextEditingController(),
        phoneController = TextEditingController(),
        cityController = TextEditingController(),
        streetController = TextEditingController(),
        homeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppLogo(size: Dimensions.hundred * 1.8),
              ),
              SizedBox(height: Dimensions.ten * 1.6),
              _DisplayNameTextField(
                displayNameController: displayNameController,
              ),
              SizedBox(height: Dimensions.fifteen),
              _EmailTextField(emailController: emailController),
              SizedBox(height: Dimensions.fifteen),
              //customer.phone == null ? _phoneInputTextField(true) :_phoneInputTextField(false),
              _PhoneTextField(phoneController: phoneController),
              SizedBox(height: Dimensions.fifteen),
              _CityTextField(
                cityController: cityController,
              ),
              SizedBox(height: Dimensions.fifteen),
              _StreetNameTextField(
                streetController: streetController,
              ),
              SizedBox(height: Dimensions.fifteen),
              _HomeTextField(
                homeController: homeController,
              ),
              SizedBox(height: Dimensions.ten * 1.6),
              BlocProvider(
                  create: (context) => UpdateUserCubit(),
                  child: _UpdateUserDetailsButton(
                    dpName: displayNameController,
                    email: emailController,
                    city: cityController,
                    street: streetController,
                    home: homeController,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisplayNameTextField extends StatelessWidget {
  final TextEditingController displayNameController;

  const _DisplayNameTextField({required this.displayNameController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
      builder: (context, state) {
        final displayName = context.read<UserDetailsCubit>().state.user.name;
        displayNameController.text = displayName ?? '';
        return UserDetailsTextField(
          controller: displayNameController,
          enabled: true,
          prefixIcon: Icons.person,
          labelText: 'Display Name',
          textInputAction: TextInputAction.next,
          onChanged: (displayName) {
            //context.read<UpdateUserCubit>().displayNameChanged(displayName);
          },
        );
      },
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key, required this.emailController})
      : super(key: key);
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
        builder: (context, state) {
      final email = context.read<UserDetailsCubit>().state.user.email;
      emailController.text = email ?? '';
      return UserDetailsTextField(
        controller: emailController,
        enabled: false,
        prefixIcon: Icons.email_rounded,
        labelText: 'Email',
        textInputAction: TextInputAction.next,
        onChanged: (email) {
          //context.read<UpdateUserCubit>().emailChanged(email);
        },
      );
    });
  }
}

class _PhoneTextField extends StatelessWidget {
  const _PhoneTextField({Key? key, required this.phoneController})
      : super(key: key);
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
        builder: (context, state) {
          final phone = context.read<UserDetailsCubit>().state.user.phone;
          //phoneController.text = phone ?? '';
          if(phone == '' || phone == null){
            return PhoneField(
              controller: phoneController,
              labelText: 'Phone Number',
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_android_rounded,
              textInputAction: TextInputAction.next,
              suffixIcon: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  //Get.toNamed(Routes.getMainPage());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<PhoneAuthCubit>(
                            create: (_) => PhoneAuthCubit(),
                            child: const BlocPhoneVerification())),
                  );
                },
                child: const Text(
                  'Add Number',
                  style: TextStyle(color: Colors.black),
                )
              ),
            );
          }
          else {
            phoneController.text = phone;
            return PhoneField(
              controller: phoneController,
              labelText: 'Phone Number',
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_android_rounded,
              textInputAction: TextInputAction.next,
              suffixIcon: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  //Get.toNamed(Routes.getMainPage());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<PhoneAuthCubit>(
                            create: (_) => PhoneAuthCubit(),
                            child: const BlocPhoneVerification())),
                  );
                },
                child: const Text(
                  'Change Number',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }
        });
  }
}

class _CityTextField extends StatelessWidget {
  const _CityTextField({Key? key, required this.cityController})
      : super(key: key);
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
        builder: (context, state) {
      final city = context.read<UserDetailsCubit>().state.user.city;
      cityController.text = city ?? '';
      return UserDetailsTextField(
        controller: cityController,
        enabled: true,
        prefixIcon: Icons.location_city_outlined,
        labelText: 'City',
        textInputAction: TextInputAction.next,
        onChanged: (city) {
          //context.read<UpdateUserCubit>().cityChanged(city);
        },
      );
    });
  }
}

class _StreetNameTextField extends StatelessWidget {
  const _StreetNameTextField({Key? key, required this.streetController})
      : super(key: key);
  final TextEditingController streetController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
        builder: (context, state) {
      final street = context.read<UserDetailsCubit>().state.user.street;
      streetController.text = street ?? '';
      return UserDetailsTextField(
        controller: streetController,
        enabled: true,
        prefixIcon: Icons.add_road_outlined,
        labelText: 'Street Name/Nbr',
        textInputAction: TextInputAction.next,
        onChanged: (street) {
          //context.read<UpdateUserCubit>().streetChanged(street);
        },
      );
    });
  }
}

class _HomeTextField extends StatelessWidget {
  const _HomeTextField({Key? key, required this.homeController})
      : super(key: key);
  final TextEditingController homeController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, DetailsState>(
        builder: (context, state) {
      final home = context.read<UserDetailsCubit>().state.user.home;
      homeController.text = home ?? '';
      return UserDetailsTextField(
        controller: homeController,
        enabled: true,
        prefixIcon: Icons.house_outlined,
        labelText: 'Apartment/House',
        textInputAction: TextInputAction.next,
        onChanged: (home) {
          //context.read<UpdateUserCubit>().homeChanged(home);
        },
      );
    });
  }
}

class _UpdateUserDetailsButton extends StatelessWidget {
  const _UpdateUserDetailsButton(
      {Key? key,
      required this.dpName,
      required this.email,
      required this.city,
      required this.street,
      required this.home})
      : super(key: key);
  final TextEditingController dpName, email, city, street, home;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserCubit, UpdateUserState>(
        builder: (context, state) {
      return state.isLoading
          ? const Center(
              child: ColoredProgressIndicator(),
            )
          : CustomButton(
              text: 'Update Details',
              onTap: () {
                context.read<UpdateUserCubit>().saveMyUser(
                      dpName.text,
                      email.text,
                      city.text,
                      street.text,
                      home.text,
                    );
              },
            );
    });
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.read<AuthRepository>().logOut(),
        icon: const Icon(Icons.logout));
  }
}
