import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/auth_failure.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsingFacebookUsecase {
  final BaseAuthRepository baseAuthRepository;

  LoginUsingFacebookUsecase({required this.baseAuthRepository});
  Future<Either<AuthFailure, UserCredential>> call() async {
    return await baseAuthRepository.loginUsingFacebook();
  }
}
