import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiKeyLocalDataSource {
  ApiKeyLocalDataSource();

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<String?> getSecuredApiKey() async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String? apiKey = await storage.read(key: 'apiKey');
    return apiKey;
  }

  Future<void> setSecuredApiKey({required String apiKey}) async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    await storage.write(key: 'apiKey', value: apiKey);
  }

  Future<void> deleteSecuredApiKey() async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    await storage.delete(key: 'apiKey');
  }
}
