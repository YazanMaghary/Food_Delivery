import 'package:ecommerce_app/features/start_up/data/provider/provider.dart';
import 'package:ecommerce_app/features/start_up/domain/usecase/location_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationUseCaseProvider = Provider((ref) {
  return LocationUsecase(baseLocationRepo: ref.read(locationRepoProvider));
});
