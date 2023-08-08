import 'package:firebase_authentication_bloc/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_authentication_bloc/pages/landing_page.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


Future<void> main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await ImageService.fetchAndCacheImageUrls();
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   androidProvider: AndroidProvider.debug,
  // );
  final authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;

  const MyApp({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (context) => AppBloc(
          authRepository: _authRepository,
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase Auth',
          home: BlocLandingPage(),
        ),
      ),
    );
    // return Provider<AuthBase>(
    //   create: (context) => Auth(),
    //   child: GetMaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Fenix',
    //     initialRoute: Routes.getInitialRoute(),
    //     getPages: Routes.routes,
    //
    //   ),
    // );
  }
}
