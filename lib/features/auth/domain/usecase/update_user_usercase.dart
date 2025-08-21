import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  UpdateUserUseCase({required this.baseAuthRepository});

  Future<void> call(UpdateUserParms parms) async {
    await baseAuthRepository.updateUser(parms.user);
  }
}

class UpdateUserParms extends Equatable {
  final Map<String, dynamic> user;

  UpdateUserParms({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
