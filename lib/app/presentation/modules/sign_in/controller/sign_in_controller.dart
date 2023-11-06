import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/sign_in_fail.dart';
import 'package:movies_app/app/domain/models/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';
import 'package:movies_app/app/presentation/modules/sign_in/controller/sign_in_state.dart';
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

  Future<Either<SignInFail, User>> submit() async {
    state = state.copyWith(isLoading: true);
    final result = await authenticationRepository.signIn(state.userName, state.password);
    
    result.when((_) => state = state.copyWith(isLoading: false), (_) => null);
    
    return result;
  }
}