import 'package:ecommerce_app/core/l10n/string_constances.dart';

class AuthFailure {
  final String? message ;
  AuthFailure({this.message});
  factory AuthFailure.weakPassword()=> AuthFailure(message: AppStringConstances.weakPassword);
  factory AuthFailure.wrongPassword()=> AuthFailure(message: AppStringConstances.wrongPassword);
  
  factory AuthFailure.emailUsedBefore()=> AuthFailure(message: AppStringConstances.emainInUse);
  factory AuthFailure.noUserFound()=> AuthFailure(message:AppStringConstances.noUserFound);
  factory AuthFailure.noInternetConncetion()=> AuthFailure(message: AppStringConstances.noInternetConncetion);
  factory AuthFailure.unkwon()=> AuthFailure(message: AppStringConstances.UnkownError);
}