import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_gpt_chat/ad_helper.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart';
import 'package:easy_gpt_chat/main.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

StreamSubscription? streamSubscription;

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
  StreamSubscription? userStream;

  start() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    getUserStream();
    if (state.currentUser == null) {
      try {
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
    }
    emit(
      state.copyWith(
        status: Status.succes,
      ),
    );

    loadAdRewarded();
    loadAdBanner();
  }

  Future<void> getUserStream() async {
    userStream = authRepository.getUserStream().listen(
      (user) {
        if (user != null) {
          emit(
            state.copyWith(
              status: Status.succes,
              currentUser: user,
            ),
          );
        } else {
          emit(
            state.copyWith(
              currentUser: null,
            ),
          );
        }
      },
    );
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String repeatPassword,
  }) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    if (password == repeatPassword) {
      try {
        await authRepository.registerUser(
          email: email,
          password: password,
        );
        getUserStream();
      } catch (e) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: e.toString(),
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'Passwords must be same',
        ),
      );
    }
  }

  Future<void> logInUser({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    try {
      await authRepository.logInUser(
        email: email,
        password: password,
      );
      getUserStream();
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await authRepository.resetPassword(email: email);
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logOutFirebaseUser() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    await authRepository.logOutUser();
    emit(
      state.copyWith(
        status: Status.succes,
        currentUser: null,
      ),
    );
  }

  Future<void> logOutUser() async {
    if (state.currentUser != null && state.currentUser!.email != 'guest') {
      await logOutFirebaseUser();
    } else {
      await deleteGuestUser();
    }
  }

  //GUEST

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

  Future<void> deleteGuestUser() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    await authRepository.deleteGuestUser();
    emit(
      state.copyWith(
        currentUser: null,
        status: Status.succes,
      ),
    );
  }

  Future<UserModel?> getGuestUser() async {
    final currentUser = await authRepository.getGuestUser();

    return currentUser;
  }

  void listenToGuestUserChanges() {
    final userStream = userBox.watch();

    streamSubscription = userStream.listen((event) {
      if (event.key == 'guestUser') {
        emit(state.copyWith(currentUser: event.value));
      }
    });
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
        if (state.currentUser!.email == 'guest') {
          await authRepository.updateGuestUser(amount: 5);
        } else {
          final currentTokens = state.currentUser!.tokens.freeTokens;
          await authRepository.updateUserTokens(
            currentTokens: currentTokens,
            amount: 5,
          );
        }
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
    streamSubscription?.cancel();
    userStream?.cancel();
    return super.close();
  }
}
