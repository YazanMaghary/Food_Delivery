import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/auth_failure.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;

  SignUpParams({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class SignupUsecase {
  final BaseAuthRepository baseAuthRepository;

  SignupUsecase({required this.baseAuthRepository});
  Future<Either<AuthFailure , UserCredential>> call(SignUpParams params){
    return baseAuthRepository.signup(email: params.email, password: params.password);
  }
}
