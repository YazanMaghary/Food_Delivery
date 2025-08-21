import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerficationUsecase {
  final BaseAuthRepository repository;

  EmailVerficationUsecase({required this.repository});
  Future<Either<String, void>> call() async {
    await FirebaseAuth.instance.currentUser?.reload();
    return await repository.emailVerfication();
  }
}
