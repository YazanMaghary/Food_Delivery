import 'package:ecommerce_app/features/start_up/data/dataSource/location_data_source.dart';
import 'package:ecommerce_app/features/start_up/data/repo/location_repo.dart';
import 'package:ecommerce_app/features/start_up/domain/repo/base_location_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationDataSourceProvider = Provider<BaseLocationDataSource>((ref) {
  return LocationDataSource();
});
final locationRepoProvider = Provider<BaseLocationRepo>((ref) {
  return LocationRepo(
    baseLocationDataSource: ref.read(locationDataSourceProvider),
  );
});
