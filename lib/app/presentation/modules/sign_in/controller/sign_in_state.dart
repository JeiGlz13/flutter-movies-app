import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String userName, password;
  final bool isLoading;

  const SignInState({
    this.userName = '',
    this.password = '',
    this.isLoading = false,
  });

  SignInState copyWith({
    String? userName,
    String? password,
    bool? isLoading,
  }) {
    return SignInState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
  
  @override
  List<Object?> get props => [
    userName, password, isLoading,
  ];
}