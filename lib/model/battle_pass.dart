class BattlePassReward {
  final int level;
  final String name;
  final String description;
  final String emoji;
  final bool isPremium;
  final RewardType type;
  final dynamic value;

  BattlePassReward({
    required this.level,
    required this.name,
    required this.description,
    required this.emoji,
    required this.isPremium,
    required this.type,
    this.value,
  });
}

enum RewardType {
  ectsBonus,
  clickBoost,
  passiveBoost,
  motivationBonus,
  skin,
  feature,
}

class BattlePass {
  static const int maxLevel = 10;
  static const int xpPerLevel = 50;

  static List<BattlePassReward> getAllRewards() {
    return [
      BattlePassReward(
        level: 1,
        name: '+5% Click Boost',
        description: 'Zwiększ kliki o 5%',
        emoji: '👆',
        isPremium: false,
        type: RewardType.clickBoost,
        value: 0.05,
      ),
      BattlePassReward(
        level: 3,
        name: 'Basic Skin',
        description: 'Odblokuj podstawowy skin',
        emoji: '🎨',
        isPremium: false,
        type: RewardType.skin,
        value: 'basic_blue',
      ),
      BattlePassReward(
        level: 5,
        name: '+10 ECTS',
        description: 'Darmowe 10 ECTS',
        emoji: '💎',
        isPremium: false,
        type: RewardType.ectsBonus,
        value: 10,
      ),
      BattlePassReward(
        level: 10,
        name: '+10% Motivation',
        description: 'Permanent +10% do bazowej motywacji',
        emoji: '🔥',
        isPremium: false,
        type: RewardType.motivationBonus,
        value: 10,
      ),
      BattlePassReward(
        level: 1,
        name: '+20% All Boost',
        description: 'x1.2 do wszystkich dochodów',
        emoji: '🚀',
        isPremium: true,
        type: RewardType.clickBoost,
        value: 0.20,
      ),
      BattlePassReward(
        level: 2,
        name: 'Coffee Unlimited',
        description: 'Permanent +15% motywacji',
        emoji: '☕',
        isPremium: true,
        type: RewardType.motivationBonus,
        value: 15,
      ),
      BattlePassReward(
        level: 5,
        name: 'Golden Student Skin',
        description: 'Ekskluzywny złoty skin',
        emoji: '👑',
        isPremium: true,
        type: RewardType.skin,
        value: 'golden_student',
      ),
      BattlePassReward(
        level: 7,
        name: '+100 ECTS',
        description: 'Ogromny bonus ECTS',
        emoji: '💰',
        isPremium: true,
        type: RewardType.ectsBonus,
        value: 100,
      ),
      BattlePassReward(
        level: 10,
        name: 'Auto-Prestige',
        description: 'Automatyczne przejście na następny semestr',
        emoji: '⚡',
        isPremium: true,
        type: RewardType.feature,
        value: 'auto_prestige',
      ),
    ];
  }

  static int getXPForLevel(int level) {
    return level * xpPerLevel;
  }
}
