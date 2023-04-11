part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(Status.initial) Status status,
    BannerAd? bannerAd,
    RewardedAd? rewardedAd,
    UserModel? currentUser,
  }) = _AuthState;
}
