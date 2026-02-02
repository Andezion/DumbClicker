import 'dart:math';

enum DealType {
  ectsBundle,
  motivationBoost,
  upgradeDiscount,
  battlePassBoost,
}

class DailyDeal {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final DealType type;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercent;
  final DateTime expiresAt;
  final dynamic value;

  DailyDeal({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.type,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercent,
    required this.expiresAt,
    this.value,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Duration get timeRemaining => expiresAt.difference(DateTime.now());

  static DailyDeal generateDailyDeal(int seed) {
    final random = Random(seed);
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dealTypes = [
      () => _createEctsBundle(random, tomorrow),
      () => _createMotivationBoost(random, tomorrow),
      () => _createUpgradeDiscount(random, tomorrow),
      () => _createBattlePassBoost(random, tomorrow),
    ];

    return dealTypes[random.nextInt(dealTypes.length)]();
  }

  static DailyDeal _createEctsBundle(Random random, DateTime expiresAt) {
    final bundles = [
      {'ects': 100, 'price': 1.99},
      {'ects': 500, 'price': 4.99},
      {'ects': 1000, 'price': 7.99},
    ];
    final bundle = bundles[random.nextInt(bundles.length)];
    final discount = 30 + random.nextInt(40);

    return DailyDeal(
      id: 'ects_bundle_${DateTime.now().day}',
      title: 'Mega ECTS Pack',
      description: '+${bundle['ects']} ECTS instantly!',
      emoji: '💎',
      type: DealType.ectsBundle,
      originalPrice: bundle['price'] as double,
      discountedPrice: (bundle['price'] as double) * (1 - discount / 100),
      discountPercent: discount,
      expiresAt: expiresAt,
      value: bundle['ects'],
    );
  }

  static DailyDeal _createMotivationBoost(Random random, DateTime expiresAt) {
    final discount = 40 + random.nextInt(30);

    return DailyDeal(
      id: 'motivation_boost_${DateTime.now().day}',
      title: 'Mega Coffee!',
      description: 'Restore 100% motivation + bonus 30 min without drop!',
      emoji: '☕',
      type: DealType.motivationBoost,
      originalPrice: 2.99,
      discountedPrice: 2.99 * (1 - discount / 100),
      discountPercent: discount,
      expiresAt: expiresAt,
      value: 100,
    );
  }

  static DailyDeal _createUpgradeDiscount(Random random, DateTime expiresAt) {
    final discount = 50 + random.nextInt(30);

    return DailyDeal(
      id: 'upgrade_discount_${DateTime.now().day}',
      title: 'All Upgrades -${50 + random.nextInt(30)}%',
      description: 'All upgrades cheaper for 24h!',
      emoji: '🔥',
      type: DealType.upgradeDiscount,
      originalPrice: 0,
      discountedPrice: 0,
      discountPercent: discount,
      expiresAt: expiresAt,
      value: discount,
    );
  }

  static DailyDeal _createBattlePassBoost(Random random, DateTime expiresAt) {
    final discount = 35 + random.nextInt(30);

    return DailyDeal(
      id: 'bp_boost_${DateTime.now().day}',
      title: 'Battle Pass XP x2',
      description: 'Double XP to Battle Pass for 24h!',
      emoji: '⚡',
      type: DealType.battlePassBoost,
      originalPrice: 1.99,
      discountedPrice: 1.99 * (1 - discount / 100),
      discountPercent: discount,
      expiresAt: expiresAt,
      value: 2.0,
    );
  }

  String getTimeRemainingString() {
    final duration = timeRemaining;
    if (duration.isNegative) return 'Expired';

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
