part of 'auth_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent{
  final User user;

  const AppUserChanged(this.user);
  @override
  List<Object> get props => [user];
}
