import 'package:easy_gpt_chat/data/loca_data_source/api_key_local_data_source.dart';
import 'package:easy_gpt_chat/domain/repositories/api_key_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiKeyLocalDataSource extends Mock implements ApiKeyLocalDataSource {}

void main() {
  late MockApiKeyLocalDataSource mockApiKeyLocalDataSource;
  late ApiKeyRepository sut;

  setUp(
    () {
      mockApiKeyLocalDataSource = MockApiKeyLocalDataSource();
      sut = ApiKeyRepository(mockApiKeyLocalDataSource);
      when(
        () => mockApiKeyLocalDataSource.getSecuredApiKey(),
      ).thenAnswer((_) async => "testString");
      when(
        () => mockApiKeyLocalDataSource.setSecuredApiKey(
            apiKey: any(named: 'apiKey')),
      ).thenAnswer(
        (_) async => {},
      );
      when(
        () => mockApiKeyLocalDataSource.deleteSecuredApiKey(),
      ).thenAnswer(
        (_) async => {},
      );
    },
  );

  test(
    'should call getSecuredApiKey() once',
    () async {
      verifyNever(
        () => mockApiKeyLocalDataSource.getSecuredApiKey(),
      );
      await sut.getSecuredApiKey();
      verify(
        () => mockApiKeyLocalDataSource.getSecuredApiKey(),
      ).called(1);
    },
  );
  test(
    'should return expected ApiKey',
    () async {
      final result = await sut.getSecuredApiKey();
      expect(result, 'testString');
    },
  );
  test(
    'should call setSecuredApiKey() once',
    () async {
      verifyNever(
        () => mockApiKeyLocalDataSource.setSecuredApiKey(
            apiKey: any(named: 'apiKey')),
      );
      await sut.setSecuredApiKey(apiKey: 'testString');
      verify(
        () => mockApiKeyLocalDataSource.setSecuredApiKey(
            apiKey: any(named: 'apiKey')),
      ).called(1);
    },
  );
  test(
    'should call deleteSecuredApiKey() once',
    () async {
      verifyNever(
        () => mockApiKeyLocalDataSource.deleteSecuredApiKey(),
      );
      await sut.deleteSecuredApiKey();
      verify(
        () => mockApiKeyLocalDataSource.deleteSecuredApiKey(),
      ).called(1);
    },
  );
}
