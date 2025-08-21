import 'package:ecommerce_app/core/model/user_model.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/widgets/failure_toasted_widget.dart';
import 'package:ecommerce_app/features/auth/data/model/auth_state.dart';
import 'package:ecommerce_app/features/auth/data/provider/auth_repository_provider.dart';

import 'package:ecommerce_app/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_using_facebook_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/signup_usecase.dart';
import 'package:ecommerce_app/features/auth/presentation/controller/signup/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'signup_controller.g.dart';

@riverpod
class SignupController extends _$SignupController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypepasswordController = TextEditingController();

  @override
  FutureOr<SignupState> build() {
    return SignupState();
  }

  void checkVisiabiltiyState() {
    if (state.value?.checkPasswordVis == false) {
      state = AsyncValue.data(state.value!.copyWith(checkPasswordVis: true));
    } else {
      state = AsyncValue.data(state.value!.copyWith(checkPasswordVis: false));
    }
  }

  void checkVisiabiltiyState2() {
    if (state.value?.checkRetypePasswordVis == false) {
      state = AsyncValue.data(
        state.value!.copyWith(checkRetypePasswordVis: true),
      );
    } else {
      state = AsyncValue.data(
        state.value!.copyWith(checkRetypePasswordVis: false),
      );
    }
  }

  bool signupValidation() {
    if (emailController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        retypepasswordController.text.isEmpty) {
      ToastedWidget.failureToastedWidget("Empty field 😒");
      return false;
    } else if (passwordController.text != retypepasswordController.text) {
      ToastedWidget.failureToastedWidget("Re-Type Password Correctly 😒");
      return false;
    } else if (!RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).+$',
    ).hasMatch(passwordController.text)) {
      ToastedWidget.failureToastedWidget(
        "Password Must Contain at least one upercase and one special 😒",
      );
      return false;
    } else {
      return true;
    }
  }

  // toster widget to pusspect to use it and refactor in in success and failure widget
  Future<AuthState?> signup() async {
    state = AsyncValue.data(
      state.value!.copyWith(signUpStatus: AuthState.loading),
    );
    AppLogger.logger.i("SignUp Status :${state.value?.signUpStatus}");
    if (signupValidation()) {
      final result = await ref
          .read(signupUsecaseProvider)
          .call(
            SignUpParams(
              email: emailController.text,
              password: passwordController.text,
            ),
          );

      result.fold(
        (l) {
          state = AsyncValue.data(
            state.value!.copyWith(signUpStatus: AuthState.error),
          );
          AppLogger.logger.i("SignUp Status :${state.value?.signUpStatus}");
          ToastedWidget.failureToastedWidget(
            "SingUp Failed reason  🥲 :${l.message}",
          );
        },
        (r) async {
          await ref
              .read(createUserUsecaseProvider)
              .call(
                CreateUserParam(
                  user: UserModel(
                    email: r.user?.email,
                    name: nameController.text,
                    id: r.user?.uid,
                    role: "user",
                    emailVerfied: r.user!.emailVerified,
                    createAt: DateTime.now(),
                  ),
                ),
              );
          state = AsyncValue.data(
            state.value!.copyWith(signUpStatus: AuthState.complete),
          );
          AppLogger.logger.i("SignUp Status :${state.value?.signUpStatus}");
          ToastedWidget.successToastedWidget("User Created Successfully");
          FirebaseAuth.instance.signOut();
        },
      );
    } else {
      state = AsyncValue.data(
        state.value!.copyWith(signUpStatus: AuthState.error),
      );
    }

    return state.value?.signUpStatus;
  }
}

final signupUsecaseProvider = Provider<SignupUsecase>((ref) {
  return SignupUsecase(baseAuthRepository: ref.read(authRepositoryProvider));
});
final createUserUsecaseProvider = Provider<CreateUserUsecase>((ref) {
  return CreateUserUsecase(
    baseAuthRepository: ref.read(authRepositoryProvider),
  );
});
final loginUsingFacebookUseCaseProvider = Provider<LoginUsingFacebookUsecase>(
  (ref) => LoginUsingFacebookUsecase(
    baseAuthRepository: ref.read(authRepositoryProvider),
  ),
);
