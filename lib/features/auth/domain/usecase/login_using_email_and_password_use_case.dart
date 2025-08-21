import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/auth_failure.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsingEmailAndPasswordParms extends Equatable {
  final String email;
  final String password;

  LoginUsingEmailAndPasswordParms({
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LoginUsingEmailAndPasswordUsecase {
  final BaseAuthRepository baseAuthRepository;

  LoginUsingEmailAndPasswordUsecase({required this.baseAuthRepository});
  Future<Either<AuthFailure, UserCredential>> call(LoginUsingEmailAndPasswordParms parms) {
    return baseAuthRepository.loginUsingFacebookAndPassword(email: parms.email, password: parms.password);
  }
}
