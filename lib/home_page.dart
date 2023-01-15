import 'package:flutter/material.dart';
import 'package:flutteradmob/admob_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  var _rewardedScore = 0;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createInterstitialAd();
    _createRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Admob'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Rewarded score is : $_rewardedScore',
                  style: TextStyle(fontSize: 30),
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: _showInterstitialAd,
                    child: Text('Interstitial Ad')),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: _showRewardedAd,
                    child: Text('Get 1 free Score')),
                Spacer(),
              ],
            ),
          ),
          bottomNavigationBar: _bannerAd == null
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: 12),
                  height: 52,
                  child: AdWidget(ad: _bannerAd!),
                )),
    );
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.InterstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd != null;
    }
  }

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobService.RewardedAdUnitId!,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => setState(() => _rewardedAd = ad),
        onAdFailedToLoad: (error) => setState(() => _rewardedAd = null),
      ),
    );
  }

  void _showRewardedAd() {
    if (_showRewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          _createRewardedAd();

        }

      );
      _rewardedAd!.show(
          onUserEarnedReward: (ad,reward)=>setState(()=>_rewardedScore++),
      );
      _rewardedAd=null;
    }
  }
}
