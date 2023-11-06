import 'package:movies_app/app/domain/models/user.dart';
abstract class AccountRepository {
  Future<User?> getUserData();
}