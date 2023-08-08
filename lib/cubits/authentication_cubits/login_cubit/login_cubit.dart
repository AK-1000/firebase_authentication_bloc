import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> logInWithCredential() async{
    if(state.status == LoginStatus.submitting){
      return ;
    }
    emit(state.copyWith(status: LoginStatus.submitting));
    try{
      await _authRepository.logIn(email: state.email, password: state.password);
      emit(state.copyWith(status: LoginStatus.success));
    }
    catch(e){
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  Future<void> logInWithGoogle() async{
    if(state.status == LoginStatus.submitting){
      return ;
    }
    emit(state.copyWith(status: LoginStatus.submitting));
    try{
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    }
    catch(e){
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

}
