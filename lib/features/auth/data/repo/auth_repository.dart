import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/auth_failure.dart';
import 'package:ecommerce_app/core/model/user_model.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/features/auth/data/dataSource/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepository({required this.baseAuthDataSource});

  @override
  Future<Either<AuthFailure, UserCredential>> signup({
    required String email,
    required String password,
  }) async {
    try {
      final result = await baseAuthDataSource.signup(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(AuthFailure.weakPassword());
      } else if (e.code == 'email-already-in-use') {
        return Left(AuthFailure.emailUsedBefore());
      } else {
        return Left(AuthFailure(message: e.message ?? "Unknown error"));
      }
    } catch (e) {
      return Left(AuthFailure.unkwon());
    }
  }

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await baseAuthDataSource.createUser(user);
    } on FirebaseException catch (e) {
      AppLogger.logger.e(e.message);
    } catch (e) {
      AppLogger.logger.e(e);
    }
  }

  @override
  Future<Either<AuthFailure, UserCredential>> loginUsingFacebook() async {
    try {
      final login = await baseAuthDataSource.loginUsingFacebook();
      return Right(login);
    } on FirebaseException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return left(AuthFailure.unkwon());
    }
  }

  @override
  Future<Either<AuthFailure, UserCredential>> loginUsingFacebookAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await baseAuthDataSource.loginUsingEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppLogger.logger.e(AuthFailure.noUserFound());
        return Left(AuthFailure.noUserFound());
      } else if (e.code == 'wrong-password') {
        AppLogger.logger.e(AuthFailure.wrongPassword());
        return Left(AuthFailure.wrongPassword());
      } else {
        return Left(AuthFailure(message: e.code));
      }
    } catch (e) {
      AppLogger.logger.e(e.toString());
      return left(AuthFailure.unkwon());
    }
  }

  @override
  Future<Either<String, void>> emailVerfication() async {
    try {
      final result = await baseAuthDataSource.emailVerfication();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      AppLogger.logger.e(e.message);

      return left(e.message ?? 'Unknown error occured');
    } catch (e) {
      AppLogger.logger.e(e.toString());
      return const Left('Unknown error occured');
    }
  }

  @override
  Future<void> updateUser(Map<String, dynamic> user) async {
    try {
      await baseAuthDataSource.updateUser(user);
    } on FirebaseException catch (e) {
      AppLogger.logger.e(e.code);
    } catch (e) {
      AppLogger.logger.e(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resetPassword(String email) async {
    try {
      final res = await baseAuthDataSource.resetPassword(email);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    } catch (e) {
      return left("Unknown error occurred!");
    }
  }
}
