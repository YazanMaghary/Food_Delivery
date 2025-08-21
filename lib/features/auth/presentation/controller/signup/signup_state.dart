import 'package:ecommerce_app/features/auth/data/model/auth_state.dart';
import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool? checkPasswordVis;
  final bool? checkRetypePasswordVis;
  final AuthState? signUpStatus;
  SignupState({
    this.checkPasswordVis = false,
    this.checkRetypePasswordVis = false,
    this.signUpStatus,
  });
  SignupState copyWith({
    AuthState? signUpStatus,
    bool? checkPasswordVis,
    bool? checkRetypePasswordVis,
  }) {
    return SignupState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      checkPasswordVis: checkPasswordVis ?? this.checkPasswordVis,
      checkRetypePasswordVis:
          checkRetypePasswordVis ?? this.checkRetypePasswordVis,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    checkPasswordVis,
    checkRetypePasswordVis,
    signUpStatus,
  ];
}
