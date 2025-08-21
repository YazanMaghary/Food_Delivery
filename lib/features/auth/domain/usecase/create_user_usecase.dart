import 'package:ecommerce_app/core/model/user_model.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUserParam extends Equatable {
  final UserModel user;

  CreateUserParam({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class CreateUserUsecase {
  final BaseAuthRepository baseAuthRepository;

  CreateUserUsecase({required this.baseAuthRepository});
  Future<void> call(CreateUserParam params) async {
    await baseAuthRepository.createUser(params.user);
  }
}
