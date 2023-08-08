import 'package:firebase_authentication_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/auth_form_cubit/authentication_form_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/authentication_cubits/login_cubit/login_cubit.dart';
import 'package:firebase_authentication_bloc/cubits/user_details_cubit/user_details_cubit.dart';
import 'package:firebase_authentication_bloc/pages/authentication_pages/authentication_page.dart';
import 'package:firebase_authentication_bloc/pages/user_info/user_info.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:firebase_authentication_bloc/repositories/user_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class BlocLandingPage extends StatelessWidget {
  const BlocLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final state = context.select((AppBloc bloc) => bloc.state.status);
    return BlocProvider(
      create: (_) => LoginCubit(
        context.read<AuthRepository>(),
      ),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {}
        },
        child: state == AppStatus.unauthenticated
            ? BlocProvider(
                create: (_) => AuthenticationFormCubit(),
                child: const AuthenticationForm(),
              )
            : RepositoryProvider.value(
                value: UserDataRepository(),
                child: BlocProvider(
                  create: (_) => UserDetailsCubit()..init(),
                  child: const UserInfo(),
                ),
              ),
        // : RepositoryProvider.value(
        //     value: userDetailsRepository,
        //     child:  BlocProvider(
        //       create: (_) => UserDetailsCubit()..init(),
        //       child: const BlocUserDetailsFirebase(),
        //     ),
        //   ),
      ),
    );
  }
}
