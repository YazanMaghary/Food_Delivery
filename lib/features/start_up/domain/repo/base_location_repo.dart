import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

abstract class BaseLocationRepo {
  Future<Either<String, Position>> determinePosition();
}
