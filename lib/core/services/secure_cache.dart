import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';

class SecureStorageService {
  // Singleton instance
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _uidKey = 'user_id';
  static const String _firstTime = "first_time";
  static const String _remmeberMe = "remmeber_me";
  static const String _userAddress = "user_address";
  // Save token
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Read token
  Future<String?> readToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Delete token
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  // Save state of first time
  Future<void> saveStateOfFirstTime(String token) async {
    await _secureStorage.write(key: _firstTime, value: token);
  }

  // Read StateOfFirstTime
  Future<String?> readStateOfFirstTime() async {
    return await _secureStorage.read(key: _firstTime);
  }

  // Delete StateOfFirstTime
  Future<void> deleteStateOfFirstTime() async {
    await _secureStorage.delete(key: _firstTime);
  }

  // Save state of first time
  Future<void> saveRemmeberMeState(String token) async {
    await _secureStorage.write(key: _remmeberMe, value: token);
  }

  // Read StateOfFirstTime
  Future<String?> readRemmeberMeState() async {
    return await _secureStorage.read(key: _remmeberMe);
  }

  // Delete StateOfFirstTime
  Future<void> deleteRemmeberMeState() async {
    await _secureStorage.delete(key: _remmeberMe);
  }

  // Save state of first time
  Future<void> saveUserAddress(String add) async {
    await _secureStorage.write(key: _userAddress, value: add.toString());
  }

  // Read StateOfFirstTime
  Future<String?> readUserAddress() async {
    return await _secureStorage.read(key: _userAddress);
  }

  // Delete StateOfFirstTime
  Future<void> deleteUserAddress() async {
    await _secureStorage.delete(key: _userAddress);
  }

  // Clear all
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
