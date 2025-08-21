import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/start_up/domain/repo/base_location_repo.dart';
import 'package:geolocator/geolocator.dart';

class LocationUsecase {
  final BaseLocationRepo baseLocationRepo;

  LocationUsecase({required this.baseLocationRepo});
  Future<Either<String, Position>> call() async {
    return await baseLocationRepo.determinePosition();
  }
}
