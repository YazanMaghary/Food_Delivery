import 'package:ecommerce_app/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class BaseAuthDataSource {
  Future<UserCredential> signup({
    required String email,
    required String password,
  });
  Future<UserCredential> loginUsingEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> createUser(UserModel user);
  Future<void> updateUser(Map<String, dynamic> user);
  Future<UserCredential> loginUsingFacebook();
  Future<void> emailVerfication();
  Future<void> resetPassword(String email);
}

class AuthDataSource extends BaseAuthDataSource {
  @override
  Future<UserCredential> signup({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  @override
  Future<void> createUser(UserModel user) async {
    final db = await FirebaseFirestore.instance;
    await db.collection("user").doc(user.id).set(user.toJson());
  }

  @override
  Future<UserCredential> loginUsingFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    );
  }

  @override
  Future<UserCredential> loginUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth;
  }

  Future<void> emailVerfication() async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification().then(
      (value) async {},
    );
  }

  @override
  Future<void> updateUser(Map<String, dynamic> user) async {
    final userCredential = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection("user")
        .doc(userCredential.uid)
        .update(user);
  }

  @override
  Future<void> resetPassword(String email) async {
    // TODO: implement resetPassword
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
