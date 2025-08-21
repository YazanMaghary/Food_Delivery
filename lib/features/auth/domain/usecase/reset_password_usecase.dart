import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class ResetPasswordParms extends Equatable {
  final String email;

  ResetPasswordParms({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class ResetPasswordUsecase {
  final BaseAuthRepository baseAuthRepository;
  ResetPasswordUsecase({required this.baseAuthRepository});
  Future<Either<String, void>> call(ResetPasswordParms parms) async {
    return await baseAuthRepository.resetPassword(parms.email);
  }
}
