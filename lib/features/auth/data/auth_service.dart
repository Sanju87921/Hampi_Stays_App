import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

/// 🔐 Secure Storage Service for managing JWT tokens and sessions
class SecureStorageService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const _tokenKey = 'hampi_stays_jwt';
  static const _roleKey = 'hampi_stays_role';

  Future<void> saveToken(String token) async => await _storage.write(key: _tokenKey, value: token);
  Future<String?> getToken() async => await _storage.read(key: _tokenKey);
  Future<void> saveRole(String role) async => await _storage.write(key: _roleKey, value: role);
  Future<String?> getRole() async => await _storage.read(key: _roleKey);
  Future<void> clear() async => await _storage.deleteAll();
}

/// 🧬 Biometric Auth Service for premium, native login
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> authenticate() async {
    try {
      if (!await isAvailable()) return false;
      
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access your HampiStays sanctuary',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}

// 📡 Providers
@riverpod
SecureStorageService secureStorage(Ref ref) => SecureStorageService();

@riverpod
BiometricService biometricService(Ref ref) => BiometricService();
