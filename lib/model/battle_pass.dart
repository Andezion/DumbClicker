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
        description: 'Increase clicks by 5%',
        emoji: '👆',
        isPremium: false,
        type: RewardType.clickBoost,
        value: 0.05,
      ),
      BattlePassReward(
        level: 3,
        name: 'Basic Skin',
        description: 'Unlock basic skin',
        emoji: '🎨',
        isPremium: false,
        type: RewardType.skin,
        value: 'basic_blue',
      ),
      BattlePassReward(
        level: 5,
        name: '+10 ECTS',
        description: 'Free 10 ECTS',
        emoji: '💎',
        isPremium: false,
        type: RewardType.ectsBonus,
        value: 10,
      ),
      BattlePassReward(
        level: 10,
        name: '+10% Motivation',
        description: 'Permanent +10% to base motivation',
        emoji: '🔥',
        isPremium: false,
        type: RewardType.motivationBonus,
        value: 10,
      ),
      BattlePassReward(
        level: 1,
        name: '+20% All Boost',
        description: 'x1.2 to all income',
        emoji: '🚀',
        isPremium: true,
        type: RewardType.clickBoost,
        value: 0.20,
      ),
      BattlePassReward(
        level: 2,
        name: 'Coffee Unlimited',
        description: 'Permanent +15% motivation',
        emoji: '☕',
        isPremium: true,
        type: RewardType.motivationBonus,
        value: 15,
      ),
      BattlePassReward(
        level: 5,
        name: 'Golden Student Skin',
        description: 'Exclusive golden skin',
        emoji: '👑',
        isPremium: true,
        type: RewardType.skin,
        value: 'golden_student',
      ),
      BattlePassReward(
        level: 7,
        name: '+100 ECTS',
        description: 'Huge ECTS bonus',
        emoji: '💰',
        isPremium: true,
        type: RewardType.ectsBonus,
        value: 100,
      ),
      BattlePassReward(
        level: 10,
        name: 'Auto-Prestige',
        description: 'Automatic transition to the next semester',
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
