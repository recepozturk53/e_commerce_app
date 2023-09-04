import 'package:e_commerce_app/models/user_model.dart';

abstract class BaseAuthRepository {
  Stream<UserModel>? get user;
  Future<void> signUp({required String email, required String password});
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
}
