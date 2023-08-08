import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_form_state.dart';

class AuthenticationFormCubit extends Cubit<AuthenticationFormState> {

  AuthenticationFormCubit() : super(AuthenticationFormState.initial());

  void toggleForm(FormType formType) async{
    emit(state.copyWith(formType: formType));
  }

}
