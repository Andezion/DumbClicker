class AdService {
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    // TODO: Initialize AdMob
    // MobileAds.instance.initialize();
    _isInitialized = true;
  }

  static Future<bool> showRewardedAd() async {
    if (!_isInitialized) {
      return false;
    }

    // TODO: Show rewarded ad
    // RewardedAd.load(...)

    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  static bool isAdReady() {
    // TODO: Check if ad is loaded
    return _isInitialized;
  }
}