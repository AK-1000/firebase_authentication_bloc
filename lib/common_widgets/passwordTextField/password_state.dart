part of 'password_cubit.dart';

enum PasswordStatus {obscure, visible}

class PasswordState extends Equatable{
  final PasswordStatus status;

  const PasswordState({
    required this.status
  });

  factory PasswordState.initial(){
    return const PasswordState(
      status: PasswordStatus.obscure,
    );
  }

  @override
  List<Object> get props => [status];

  PasswordState copyWith({
    PasswordStatus? status
  }) {
    return PasswordState(
      status: status?? this.status,
    );
  }

}