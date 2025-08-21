import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/start_up/data/dataSource/location_data_source.dart';
import 'package:ecommerce_app/features/start_up/domain/repo/base_location_repo.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';

class LocationRepo extends BaseLocationRepo {
  final BaseLocationDataSource baseLocationDataSource;

  LocationRepo({required this.baseLocationDataSource});
  @override
  Future<Either<String, Position>> determinePosition() async {
    try {
      final position = await baseLocationDataSource.determinePosition();
      return Right(position);
    } catch (e) {
      return left(e.toString());
    }
  }
}
