import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit(this._authRepository) : super(SignUpState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPassword: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  void displayNameChanged(String value) {
    emit(
      state.copyWith(
        displayName: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (state.status == SignUpStatus.submitting) return;
    try {
      await _authRepository.signUp(
          displayName: state.displayName,
          email: state.email,
          password: state.password);
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: SignUpStatus.error));
    }
  }
}
