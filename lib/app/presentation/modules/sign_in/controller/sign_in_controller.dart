import 'package:movies_app/app/domain/either.dart';
import 'package:movies_app/app/domain/enums/fails/sign_in/sign_in_failure.dart';
import 'package:movies_app/app/domain/models/user/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'package:movies_app/app/presentation/global/controllers/session_controller.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';
import 'package:movies_app/app/presentation/modules/sign_in/controller/state/sign_in_state.dart';
class SignInController extends StateNotifier<SignInState> {
  final AuthenticationRepository authenticationRepository;
  final SessionController sessionController;
  final FavoritesController favoritesController;

  SignInController(super.state, {
    required this.sessionController,
    required this.favoritesController,
    required this.authenticationRepository,
  });

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
      success: (user) {
        sessionController.setUser(user);
        favoritesController.init();
      },
    );
    
    return result;
  }
}