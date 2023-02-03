import 'package:easy_gpt_chat/data/loca_data_source/api_key_local_data_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApiKeyRepository {
  ApiKeyRepository(this.apiKeyLocalDataSource);
  final ApiKeyLocalDataSource apiKeyLocalDataSource;

  Future<String?> getSecuredApiKey() async {
    return apiKeyLocalDataSource.getSecuredApiKey();
  }

  Future<void> setSecuredApiKey({required String apiKey}) async {
    await apiKeyLocalDataSource.setSecuredApiKey(apiKey: apiKey);
  }

  Future<void> deleteSecuredApiKey() async {
    return apiKeyLocalDataSource.deleteSecuredApiKey();
  }
}
