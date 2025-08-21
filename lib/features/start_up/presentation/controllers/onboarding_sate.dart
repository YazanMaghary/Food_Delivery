import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum buttonStatus { getStarted, next }

class OnboardingSate extends Equatable {
  const OnboardingSate({this.currentPage, this.pageController, this.status});

  final double? currentPage;
  final PageController? pageController;
  final buttonStatus? status;

  OnboardingSate copyWith({
    double? currentPage,
    PageController? pageController,
    buttonStatus? status,
  }) {
    return OnboardingSate(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [currentPage, pageController, status];
}
