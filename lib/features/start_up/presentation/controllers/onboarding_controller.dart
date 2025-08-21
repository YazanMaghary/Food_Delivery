import 'package:ecommerce_app/features/start_up/presentation/controllers/onboarding_sate.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  final PageController _controller = PageController();
  PageController get controller => _controller;
  @override
  OnboardingSate build() {
    controller.addListener(() {
      state = state.copyWith(currentPage: controller.page ?? 0);
    });
    ref.onDispose(() {
      controller.dispose();
      state.pageController?.dispose();
    });
    return OnboardingSate(currentPage: 0, pageController: controller);
  }

  void nextPage(int listLength) {
    final status =
        state.currentPage == listLength - 1
            ? buttonStatus.getStarted
            : buttonStatus.next;
    switch (status) {
      case buttonStatus.getStarted:
        break;
      case buttonStatus.next:
        state = state.copyWith(currentPage: state.currentPage! + 1);
        state.pageController?.animateToPage(
          state.currentPage!.toInt(),
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
        break;
    }
  }

  void buttonDirect(int listLength) {
    final status =
        state.currentPage == listLength - 1
            ? buttonStatus.getStarted
            : buttonStatus.next;

    state = state.copyWith(status: status);
  }
}
