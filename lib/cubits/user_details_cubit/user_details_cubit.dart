import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_bloc/models/user_model.dart';
import 'package:firebase_authentication_bloc/repositories/user_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<DetailsState> {
  // Get the injected MyUserRepository
  final UserDataRepository _userRepository;
  StreamSubscription? _myUsersSubscription;

  UserDetailsCubit() : _userRepository = UserDataRepository(), super(const DetailsState());

  Future<void> init() async {
    // Subscribe to listen for changes in the myUser list
    _myUsersSubscription = _userRepository.getMyUsers().listen(myUserListen);
  }

  // Every time the myUser list is updated, this function will be called
  // with the latest data
  void myUserListen(User user) async {
    emit(DetailsState(
      isLoading: false,
      user: user,
    ));
  }

  @override
  Future<void> close() async{
    _myUsersSubscription?.cancel();
    return super.close();
  }

}