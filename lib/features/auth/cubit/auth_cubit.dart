import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_gpt_chat/ad_helper.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  start() async {
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

          print('$ad loaded.');
          emit(state.copyWith(rewardedAd: ad));
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showAdRewarded() async {
    state.rewardedAd?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        //give for user some candies :D
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

  @override
  Future<void> close() {
    state.bannerAd?.dispose();
    state.rewardedAd?.dispose();
    return super.close();
  }
}
