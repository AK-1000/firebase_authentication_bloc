import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository) : super(ResetPasswordState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: ResetPasswordStatus.initial,
      ),
    );
  }

  Future<void> resetPasswordSubmitted() async {
    if (state.status == ResetPasswordStatus.submitting) return;
    try {
      await _authRepository.resetPassword(state.email);
      emit(state.copyWith(status: ResetPasswordStatus.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ResetPasswordStatus.error));
    }
  }
}
