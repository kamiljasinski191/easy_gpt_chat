// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart'
    as _i3;
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart'
    as _i4;
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ChatGptRemoteDataSource>(
        () => _i3.ChatGptRemoteDataSource());
    gh.factory<_i4.ChatGptRepository>(
        () => _i4.ChatGptRepository(gh<_i3.ChatGptRemoteDataSource>()));
    gh.factory<_i5.ChatCubit>(() => _i5.ChatCubit(gh<_i4.ChatGptRepository>()));
    return this;
  }
}
