// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:easy_gpt_chat/data/loca_data_source/hive_local_data_source.dart'
    as _i6;
import 'package:easy_gpt_chat/data/remote_data_source/auth_remote_data_source.dart'
    as _i3;
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart'
    as _i4;
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart' as _i7;
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart'
    as _i5;
import 'package:easy_gpt_chat/features/auth/cubit/auth_cubit.dart' as _i9;
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthRemoteDataSource>(() => _i3.AuthRemoteDataSource());
    gh.factory<_i4.ChatGptRemoteDataSource>(
        () => _i4.ChatGptRemoteDataSource());
    gh.factory<_i5.ChatGptRepository>(
        () => _i5.ChatGptRepository(gh<_i4.ChatGptRemoteDataSource>()));
    gh.factory<_i6.HiveLocalDataSource>(() => _i6.HiveLocalDataSource());
    gh.factory<_i7.AuthRepository>(() => _i7.AuthRepository(
          gh<_i6.HiveLocalDataSource>(),
          gh<_i3.AuthRemoteDataSource>(),
        ));
    gh.factory<_i8.ChatCubit>(() => _i8.ChatCubit(
          gh<_i5.ChatGptRepository>(),
          gh<_i7.AuthRepository>(),
        ));
    gh.factory<_i9.AuthCubit>(() => _i9.AuthCubit(gh<_i7.AuthRepository>()));
    return this;
  }
}
