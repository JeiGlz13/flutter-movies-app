import 'package:movies_app/app/domain/models/user/user.dart';
abstract class AccountRepository {
  Future<User?> getUserData();
}