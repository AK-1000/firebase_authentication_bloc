// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:handling_finance/blocs/user_data_bloc/user_data_repository.dart';
// import 'package:handling_finance/models/user_model.dart';
//
// part 'user_data_event.dart';
// part 'user_data_state.dart';
//
// class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
//   final UserDataRepository userRepository;
//   StreamSubscription? userDataSubscription;
//
//   UserDataBloc({required this.userRepository}) : super(UserDataInitial()) {
//     on<FetchUserData>((event, emit) {
//       // Add your logic here
//     });
//   }
//
//
//   @override
//   Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
//     if (event is FetchUserData) {
//       yield* _mapFetchUserDataToState();
//     } else if (event is UpdateUserData) {
//       yield* _mapUpdateUserDataToState(event);
//     }
//   }
//
//   Stream<UserDataState> _mapFetchUserDataToState() async* {
//     yield UserDataLoading();
//     try {
//       userDataSubscription?.cancel();
//       userDataSubscription = userRepository.getUserData().listen(
//             (userMap) {
//           final user = User.fromMap(userMap);
//           add(UpdateUserData(user));
//         },
//       );
//     } catch (e) {
//       yield UserDataError(message: 'Failed to fetch user data.');
//     }
//   }
//
//   Stream<UserDataState> _mapUpdateUserDataToState(UpdateUserData event) async* {
//     yield UserDataLoaded(user: event.user);
//   }
//
//   @override
//   Future<void> close() {
//     userDataSubscription?.cancel();
//     return super.close();
//   }
// }
