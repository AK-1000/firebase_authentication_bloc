part of 'reset_password_cubit.dart';

enum ResetPasswordStatus {initial, submitting, success, error}

class ResetPasswordState extends Equatable{
  final String email;
  final ResetPasswordStatus status;

  const ResetPasswordState({
    required this.email,
    required this.status
  });

  factory ResetPasswordState.initial(){
    return const ResetPasswordState(
      email: '',
      status: ResetPasswordStatus.initial,
    );
  }

  @override
  List<Object> get props => [email,status];

  ResetPasswordState copyWith({
    String? email,
    ResetPasswordStatus? status
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      status: status?? this.status,
    );
  }

}