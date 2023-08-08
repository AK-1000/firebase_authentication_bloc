part of 'user_details_cubit.dart';

class DetailsState extends Equatable {
  final bool isLoading;
  final User user;

  const DetailsState({
    this.isLoading = true,
    this.user = User.empty,
  });

  @override
  List<Object?> get props => [isLoading, user];
}