import 'package:movies_app/app/domain/models/user.dart';
import 'package:movies_app/app/domain/repositories/authentication_repository.dart';
import 'package:movies_app/app/presentation/global/state_notifier.dart';

class SessionController extends StateNotifier<User?> {
  final AuthenticationRepository authenticationRepository;
  SessionController({ required this.authenticationRepository }): super(null);


  void setUser(User user) {
    state = user;
  }

  Future<void> signOut() async {
    await authenticationRepository.signOut();
    onlyUpdate(null);
  }
}