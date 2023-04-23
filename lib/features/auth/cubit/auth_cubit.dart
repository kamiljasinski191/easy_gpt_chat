import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_gpt_chat/ad_helper.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.authRepository,
  ) : super(
          const AuthState(
            status: Status.initial,
          ),
        );

  final AuthRepository authRepository;

  start() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    try {
      Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      final currentUser = await getGuestUser();
      emit(
        state.copyWith(
          currentUser: currentUser,
        ),
      );
      emit(
        state.copyWith(
          status: Status.succes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
        ),
      );
    }
    loadAdRewarded();
    loadAdBanner();
  }

  Future<void> loadAdRewarded() async {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdClicked: (ad) {});

          emit(state.copyWith(rewardedAd: ad));
        },
        onAdFailedToLoad: (LoadAdError error) {
          emit(
            state.copyWith(
                status: Status.error,
                errorMessage: 'RewardedAd failed to load: $error'),
          );
        },
      ),
    );
  }

  Future<void> showAdRewarded() async {
    state.rewardedAd?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
        await authRepository.updateGuestUser(amount: 5);
        await start();
      },
    );
    loadAdRewarded();
  }

  Future<void> loadAdBanner() async {
    if (Platform.isAndroid) {
      BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            emit(state.copyWith(bannerAd: ad as BannerAd));
          },
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
          },
        ),
      ).load();
    }
  }

  Future<void> loginAsGuest() async {
    emit(state.copyWith(status: Status.loading));
    final currentUser = await authRepository.loginAsGuest();

    emit(
      state.copyWith(
        currentUser: currentUser,
        status: Status.succes,
      ),
    );
  }

  Future<UserModel?> getGuestUser() async {
    final currentUser = await authRepository.getGuestUser();

    return currentUser;
  }

  @override
  Future<void> close() {
    state.bannerAd?.dispose();
    state.rewardedAd?.dispose();
    return super.close();
  }
}
