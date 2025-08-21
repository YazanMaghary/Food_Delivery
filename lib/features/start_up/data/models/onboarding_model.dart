import 'package:equatable/equatable.dart';

class OnboardingModel extends Equatable {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
