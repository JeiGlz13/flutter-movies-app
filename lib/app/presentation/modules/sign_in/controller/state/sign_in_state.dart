import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String userName,
    @Default('') String password,
    @Default(false) bool isLoading,
  }) = _SignInState;
}