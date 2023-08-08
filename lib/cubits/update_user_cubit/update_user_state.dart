part of 'update_user_cubit.dart';

class UpdateUserState extends Equatable {
  final bool isLoading;

  // In the presentation layer, we will check the value of isDone.
  // When it is true, we will navigate to the previous page
  final bool isDone;

  const UpdateUserState({
    this.isLoading = false,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [isLoading, isDone];

  // Helper function that updates some properties of this object,
  // and returns a new updated instance of EditMyUserState
  UpdateUserState copyWith({
    bool? isLoading,
    bool? isDone,
  }) {
    return UpdateUserState(
      isLoading: isLoading ?? this.isLoading,
      isDone: isDone ?? this.isDone,
    );
  }
}