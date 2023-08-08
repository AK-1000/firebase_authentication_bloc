part of 'sign_up_cubit.dart';

enum SignUpStatus {initial, submitting, success, error}

class SignUpState extends Equatable{
  final String displayName;
  final String email;
  final String password;
  final String confirmPassword;
  final SignUpStatus status;

  const SignUpState({
    required this.displayName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.status
  });

  factory SignUpState.initial(){
    return const SignUpState(
      displayName: '',
      email: '',
      password: '',
      confirmPassword: '',
      status: SignUpStatus.initial,
    );
  }

  @override
  List<Object> get props => [displayName,email,password,confirmPassword,status];

  SignUpState copyWith({
    String? displayName,
    String? email,
    String? password,
    String? confirmPassword,
    SignUpStatus? status
  }) {
    return SignUpState(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status?? this.status,
    );
  }

}