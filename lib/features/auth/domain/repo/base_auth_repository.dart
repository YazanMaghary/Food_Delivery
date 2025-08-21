import "package:dartz/dartz.dart";
import "package:ecommerce_app/core/errors/auth_failure.dart";
import "package:ecommerce_app/core/model/user_model.dart";
import "package:firebase_auth/firebase_auth.dart";

abstract class BaseAuthRepository {
  Future<Either<AuthFailure, UserCredential>> signup({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, UserCredential>> loginUsingFacebookAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, UserCredential>> loginUsingFacebook();
  Future<void> createUser(UserModel user);
  Future<void> updateUser(Map<String, dynamic> user);
  Future<Either<String, void>> emailVerfication();
  Future<Either<String, void>> resetPassword(String email);
}
