import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, this.popable = false}) : super(key: key);
  final bool popable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimensions.thirtyFive,
          left: Dimensions.five,
          right: Dimensions.five),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF282941),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          popable
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFE0A43C),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.eight,
                    ),
                    const Image(image: AssetImage('assets/logo/fenix.png')),
                  ],
                )
              : const Image(image: AssetImage('assets/logo/fenix.png')),
          IconButton(
            onPressed: () => context.read<AuthRepository>().logOut(),
            icon: const Icon(Icons.logout, color: Color(0xFFE0A43C)),
          ),
        ],
      ),
    );
  }
}
