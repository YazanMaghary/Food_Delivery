import 'package:ecommerce_app/features/auth/data/provider/auth_repository_provider.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/email_verfication_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_using_email_and_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_using_facebook_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/update_user_usercase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupUsecaseProvider = Provider<SignupUsecase>((ref) {
  return SignupUsecase(baseAuthRepository: ref.read(authRepositoryProvider));
});
final createUserUsecaseProvider = Provider<CreateUserUsecase>((ref) {
  return CreateUserUsecase(
    baseAuthRepository: ref.read(authRepositoryProvider),
  );
});
final loginUsingFacebookUseCaseProvider = Provider<LoginUsingFacebookUsecase>(
  (ref) => LoginUsingFacebookUsecase(
    baseAuthRepository: ref.read(authRepositoryProvider),
  ),
);
final loginUsingEmailAndPasswordUseCaseProvider =
    Provider<LoginUsingEmailAndPasswordUsecase>(
      (ref) => LoginUsingEmailAndPasswordUsecase(
        baseAuthRepository: ref.read(authRepositoryProvider),
      ),
    );
final emailVerficationUsecaseProvider = Provider<EmailVerficationUsecase>(
  (ref) =>
      EmailVerficationUsecase(repository: ref.read(authRepositoryProvider)),
);
final updateUserUseCaseProvider = Provider<UpdateUserUseCase>(
  (ref) =>
      UpdateUserUseCase(baseAuthRepository: ref.read(authRepositoryProvider)),
);
final resetPasswordUseCaseProvider = Provider<ResetPasswordUsecase>(
  (ref) => ResetPasswordUsecase(
    baseAuthRepository: ref.read(authRepositoryProvider),
  ),
);
