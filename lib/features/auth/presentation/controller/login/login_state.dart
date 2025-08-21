import 'package:ecommerce_app/features/auth/data/model/auth_state.dart';
import 'package:equatable/equatable.dart';

enum VerficationState { loading, completed, error, verficationRequested }

class LoginState extends Equatable {
  LoginState({
    this.timerCheck,
    this.timer,
    this.checkBoxState,
    this.checkPasswordVis = false,
    this.loginState,
    this.verficationState,
  });
  final bool? checkBoxState;
  final bool? checkPasswordVis;
  final AuthState? loginState;
  final VerficationState? verficationState;
  final int? timer;
  final bool? timerCheck;
  LoginState copyWith({
    final bool? checkBoxState,
    final bool? checkPasswordVis,
    final AuthState? loginState,
    final VerficationState? verficationState,
    final int? timer,
    final bool? timerCheck,
  }) {
    return LoginState(
      checkBoxState: checkBoxState ?? this.checkBoxState,
      checkPasswordVis: checkPasswordVis ?? this.checkPasswordVis,
      loginState: loginState ?? this.loginState,
      verficationState: verficationState ?? this.verficationState,
      timer: timer ?? this.timer,
      timerCheck: timerCheck ?? this.timerCheck,
    );
  }

  @override
  List<Object?> get props => [
    checkBoxState,
    checkPasswordVis,
    loginState,
    verficationState,
    timer,
    timerCheck,
  ];
}
