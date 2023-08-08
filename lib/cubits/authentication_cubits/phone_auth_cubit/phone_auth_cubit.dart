import 'package:equatable/equatable.dart';
import 'package:firebase_authentication_bloc/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  // Get the injected MyUserRepository
  final AuthRepository _authRepository;

  // When we are editing an existing myUser _toEdit won't be null

  PhoneAuthCubit()
      : _authRepository = AuthRepository(),
        super(const PhoneAuthState());

  // This function will be called from the presentation layer
  // when an image is selected

  // This function will be called from the presentation layer
  // when the user has to be saved
  Future<void> verifyPhone(String phone) async {
    emit(state.copyWith(isLoading: true));
    await _authRepository.verifyPhone(phone);
    Future.delayed(Duration(seconds: 3)).then((_) {
      return emit(state.copyWith(isLoading: false, formType: PhoneAuthFormType.smsCode, phone: phone));
    });
  }

  Future<void> verifySMSCode(String sms) async{
    emit(state.copyWith(isLoading: true));
    await _authRepository.verifySMS(smsCode: sms, phone: state.phone);
    Future.delayed(Duration(seconds: 3)).then((_) {
      return emit(state.copyWith(isDone: true, isLoading: false, formType: PhoneAuthFormType.smsCode));
    });
  }

}
