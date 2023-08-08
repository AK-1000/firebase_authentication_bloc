import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {

  PasswordCubit() : super(PasswordState.initial());

  void toggleStatus() async{
    if(state.status == PasswordStatus.obscure){
      emit(state.copyWith(status: PasswordStatus.visible));
    }
    else{
      emit(state.copyWith(status: PasswordStatus.obscure));
    }
  }

}
