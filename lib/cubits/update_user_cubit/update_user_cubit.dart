import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_bloc/models/user_model.dart';
import 'package:firebase_authentication_bloc/repositories/user_data_repository.dart';
import 'package:firebase_authentication_bloc/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  // Get the injected MyUserRepository
  final UserDataRepository _userRepository;

  // When we are editing an existing myUser _toEdit won't be null

  UpdateUserCubit()
      : _userRepository = UserDataRepository(),
        super(const UpdateUserState());

  // This function will be called from the presentation layer
  // when an image is selected

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> saveMyUser(String displayName, String email, String city,
      String street, String home) async {
    emit(state.copyWith(isLoading: true));

    // If we are editing, we use the existing id. Otherwise, create a new one.
    User updated = User(
      id: '',
      name: displayName,
      email: email,
      city: city,
      street: street,
      home: home,
    );
    await _userRepository.updateDetails(
      user: updated,
    );
    Get.showSnackbar(
      GetSnackBar(
        borderRadius: Dimensions.ten,
        dismissDirection: DismissDirection.startToEnd,
        margin: EdgeInsets.symmetric(horizontal: Dimensions.forty),
        titleText: const Text(
          'Update Complete',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        messageText: const Text(
          'Your credentials were updated successfully',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
      ),
    );
    emit(state.copyWith(isDone: true, isLoading: false));
  }
}
