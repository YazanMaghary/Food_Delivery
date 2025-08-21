//providers
import 'package:ecommerce_app/features/auth/data/dataSource/auth_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repo/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/repo/base_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataSourceProvider = Provider<BaseAuthDataSource>((ref) {
  return AuthDataSource();
});
final authRepositoryProvider = Provider<BaseAuthRepository>((ref) {
  return AuthRepository(
    baseAuthDataSource: ref.read(authDataSourceProvider),
  ); //change to watch if needed
});
