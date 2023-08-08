part of 'authentication_form_cubit.dart';

enum FormType {signIn, signUp, resetPassword, confirmEmail}

class AuthenticationFormState extends Equatable{
  final FormType formType;

  const AuthenticationFormState({
    required this.formType
  });

  factory AuthenticationFormState.initial(){
    return const AuthenticationFormState(
      formType: FormType.signIn,
    );
  }

  @override
  List<Object> get props => [formType];

  AuthenticationFormState copyWith({
    FormType? formType
  }) {
    return AuthenticationFormState(
      formType: formType?? this.formType,
    );
  }

}