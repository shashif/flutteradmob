import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }

    return null;
  }

  static String? get InterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }

    return null;
  }

  static String? get RewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5224354917';
    }

    return null;
  }

  static final BannerAdListener bannerAdListener=BannerAdListener(
    onAdLoaded: (ad)=> debugPrint('ad loaded'),
    onAdFailedToLoad: (ad,error){
      ad.dispose();
      debugPrint('Ad failed to load : $error');
    },
    onAdOpened: (ad)=> debugPrint('ad opened'),
    onAdClosed: (ad)=> debugPrint('ad Closed'),

  );
}
