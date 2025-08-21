import 'package:ecommerce_app/core/model/user_model.dart';
import 'package:ecommerce_app/core/services/app_logger.dart';
import 'package:ecommerce_app/core/services/secure_cache.dart';
import 'package:ecommerce_app/core/widgets/failure_toasted_widget.dart';
import 'package:ecommerce_app/features/auth/data/model/auth_state.dart';
import 'package:ecommerce_app/features/auth/data/provider/auth_repository_provider.dart';
import 'package:ecommerce_app/features/auth/domain/provider/usecase_provider.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/login_using_email_and_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecase/update_user_usercase.dart';
import 'package:ecommerce_app/features/auth/presentation/controller/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  final firstNode = FocusNode();
  final secondNode = FocusNode();
  @override
  Future<LoginState> build() async {
    final remm = await SecureStorageService().readRemmeberMeState();
    AppLogger.logger.i("CheckBox State For remmeber me ${remm}");
    final checkboxstate = remm == "true" ? true : false;
    return LoginState(checkBoxState: checkboxstate);
  }

  void unFocusKeyboard() {
    firstNode.unfocus();
    secondNode.unfocus();
  }

  void checkBoxStateChanged(bool value) async {
    if (value == true) {
      state = AsyncValue.data(state.value!.copyWith(checkBoxState: true));
      await SecureStorageService().saveRemmeberMeState(true.toString());
    } else if (value == false) {
      state = AsyncValue.data(state.value!.copyWith(checkBoxState: false));
      await SecureStorageService().saveRemmeberMeState(false.toString());
    }
  }

  bool loginValidation() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<(AuthState?, String?)> loginUsingEmailAndPassword() async {
    state = AsyncValue.data(
      state.value!.copyWith(loginState: AuthState.loading),
    );
    String? message;
    AppLogger.logger.i(
      "Login Using Email And Password State${state.value?.loginState}",
    );
    final check = loginValidation();
    AuthState? authstate = AuthState.loading;
    if (check) {
      final res = await ref
          .read(loginUsingEmailAndPasswordUseCaseProvider)
          .call(
            LoginUsingEmailAndPasswordParms(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
      res.fold(
        (failed) {
          state = AsyncValue.data(
            state.value!.copyWith(loginState: AuthState.error),
          );
          authstate = AuthState.error;

          AppLogger.logger.e(
            "Login Using Email And Password State${state.value?.loginState}",
          );
          message = failed.message;
        },
        (usercredential) {
          state = AsyncValue.data(
            state.value!.copyWith(loginState: AuthState.complete),
          );
          authstate = AuthState.complete;
          AppLogger.logger.i(
            "Login Using Email And Password State${state.value?.loginState}",
          );
          AppLogger.logger.f("Hello User :${usercredential.user?.email}");
          message = "User Logged In Successfully 😊";
        },
      );
    } else {
      state = AsyncValue.data(
        state.value!.copyWith(loginState: AuthState.error),
      );
      authstate = AuthState.error;
    }
    return (authstate, message);
  }

  void checkVisiabiltiyState() {
    if (state.value?.checkPasswordVis == false) {
      state = AsyncValue.data(state.value!.copyWith(checkPasswordVis: true));
    } else {
      state = AsyncValue.data(state.value!.copyWith(checkPasswordVis: false));
    }
  }

  Future<AuthState?> logingUsingFacebook() async {
    state = AsyncValue.data(
      state.value!.copyWith(loginState: AuthState.loading),
    );
    AppLogger.logger.i("Login Using FaceBook State${state.value?.loginState}");
    final result = await ref.read(loginUsingFacebookUseCaseProvider).call();
    result.fold(
      (failed) {
        state = AsyncValue.data(
          state.value!.copyWith(loginState: AuthState.error),
        );
        AppLogger.logger.e(
          "Login Using FaceBook State${state.value?.loginState}",
        );
        ToastedWidget.failureToastedWidget(failed.message);
      },
      (userCredential) async {
        await ref
            .read(createUserUsecaseProvider)
            .call(
              CreateUserParam(
                user: UserModel(
                  email: userCredential.user?.email,
                  name: userCredential.user?.displayName,
                  id: userCredential.user?.uid,
                  role: "user",
                  emailVerfied: userCredential.user!.emailVerified,
                  createAt: DateTime.now(),
                ),
              ),
            );
        state = AsyncValue.data(
          state.value!.copyWith(loginState: AuthState.complete),
        );
        AppLogger.logger.i(
          "Login Using FaceBook State${state.value?.loginState}",
        );
        ToastedWidget.successToastedWidget("User Logged In Successfully 😊");
        AppLogger.logger.i("User Credintial : {$userCredential}");
      },
    );
    return state.value?.loginState;
  }

  Future<VerficationState?> sendEmailVerification() async {
    final user = await ref.read(authRepositoryProvider).emailVerfication();
    final userCredential = FirebaseAuth.instance.currentUser;
    state = AsyncValue.data(
      state.value!.copyWith(verficationState: VerficationState.loading),
    );
    if (userCredential!.emailVerified) {
      AppLogger.logger.i("Email is already verified");
      ToastedWidget.successToastedWidget("Email is already verified");
      state = AsyncValue.data(
        state.value!.copyWith(verficationState: VerficationState.completed),
      );
    } else {
      user.fold(
        (failed) {
          AppLogger.logger.e("Email Verification Failed: ${failed}");
          ToastedWidget.failureToastedWidget(failed);
          state = AsyncValue.data(
            state.value!.copyWith(verficationState: VerficationState.error),
          );
        },
        (success) async {
          AppLogger.logger.i("Email Verification Sent Successfully");
          ToastedWidget.successToastedWidget(
            "Email Verification Sent Successfully,Check Your Email",
          );
          state = AsyncValue.data(
            state.value!.copyWith(
              verficationState: VerficationState.verficationRequested,
            ),
          );
          await ref
              .read(updateUserUseCaseProvider)
              .call(UpdateUserParms(user: {"emailVerfied": true}));
        },
      );
    }

    return state.value!.verficationState;
  }

  Future<bool> timer() async {
    int timer = 60;

    bool verficationstate = true;
    state = AsyncValue.data(state.value!.copyWith(timer: timer));
    state = AsyncValue.data(
      state.value!.copyWith(timerCheck: verficationstate),
    );
    while (timer > 0) {
      await Future.delayed(const Duration(seconds: 1), () {
        timer--;
        state = AsyncValue.data(state.value!.copyWith(timer: timer));
        AppLogger.logger.i("Timer Value : ${state.value?.timer}");
      });
      verficationstate = false;
      state = AsyncValue.data(
        state.value!.copyWith(timerCheck: verficationstate),
      );
    }
    if (timer == 0) {
      timer = 60;
      verficationstate = true;
      state = AsyncValue.data(
        state.value!.copyWith(timerCheck: verficationstate),
      );
    }
    return state.value!.timerCheck!;
  }

  Future<AuthState> resetPassword() async {
    final email = emailController.text.trim();
    AuthState? authState;
    if (email.isEmpty) {
      ToastedWidget.failureToastedWidget("Please enter your email");
    } else {
      state = AsyncValue.data(
        state.value!.copyWith(loginState: AuthState.loading),
      );
      authState = state.value!.loginState;
      final result = await ref
          .read(resetPasswordUseCaseProvider)
          .call(ResetPasswordParms(email: email));
      result.fold(
        (failure) {
          state = AsyncValue.data(
            state.value!.copyWith(loginState: AuthState.error),
          );
          authState = state.value!.loginState;
          ToastedWidget.failureToastedWidget(failure);
        },
        (_) {
          state = AsyncValue.data(
            state.value!.copyWith(loginState: AuthState.complete),
          );
          authState = state.value!.loginState;
          ToastedWidget.successToastedWidget(
            "Password reset email sent successfully",
          );
        },
      );
    }
    return authState ?? AuthState.loading;
  }
}
