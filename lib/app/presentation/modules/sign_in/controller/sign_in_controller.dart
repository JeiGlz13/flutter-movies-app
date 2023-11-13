import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/sign_in/sign_in_failure.dart';
import 'package:movies_app/app/domain/models/user/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';
import 'package:movies_app/app/presentation/modules/sign_in/controller/state/sign_in_state.dart';
class SignInController extends StateNotifier<SignInState> {
  final AuthenticationRepository authenticationRepository;

  SignInController(super.state, { required this.authenticationRepository });

  void onUsernameChanged(String text) {
    onlyUpdate(
      state.copyWith(userName: text.trim().toLowerCase()),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(password: text.trim()),
    );
  }

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(isLoading: true);
    final result = await authenticationRepository.signIn(state.userName, state.password);
    
    result.when(
      error: (_) => state = state.copyWith(isLoading: false),
      success: (_) => null,
    );
    
    return result;
  }
}