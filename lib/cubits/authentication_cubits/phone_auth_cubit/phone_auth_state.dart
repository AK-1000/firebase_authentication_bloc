part of 'phone_auth_cubit.dart';
enum PhoneAuthFormType {phoneEntry , smsCode}
class PhoneAuthState extends Equatable {
  final bool isLoading;
  final String phone;
  final PhoneAuthFormType formType;
  // In the presentation layer, we will check the value of isDone.
  // When it is true, we will navigate to the previous page
  final bool isDone;

  const PhoneAuthState({
    this.isLoading = false,
    this.phone='',
    this.formType = PhoneAuthFormType.phoneEntry,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [isLoading, phone,formType, isDone];

  // Helper function that updates some properties of this object,
  // and returns a new updated instance of EditMyUserState
  PhoneAuthState copyWith({
    bool? isLoading,
    String? phone,
    PhoneAuthFormType? formType,
    bool? isDone,
  }) {
    return PhoneAuthState(
      isLoading: isLoading ?? this.isLoading,
      phone: phone ?? this.phone,
      formType: formType ?? this.formType,
      isDone: isDone ?? this.isDone,
    );
  }
}