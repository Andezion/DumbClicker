enum UpgradeType {
  clickBoost,
  autoClick,
  multiplier,
}

class Upgrade {
  final String id;
  final String name;
  final String description;
  final String emoji;
  final double basePrice;
  final String effect;
  final UpgradeType type;
  final String requiredEducationLevel;

  Upgrade({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
    required this.basePrice,
    required this.effect,
    required this.type,
    this.requiredEducationLevel = 'Licencjat',
  });

  double getPrice(int level) {
    return basePrice * (1.15 * (level + 1));
  }

  static List<Upgrade> getAllUpgrades() {
    return [
      Upgrade(
        id: 'laptop',
        name: 'New Laptop',
        description: '+0.1 ECTS per click',
        emoji: '💻',
        basePrice: 25,
        effect: '+0.1/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'coffee',
        name: 'Coffee for the Night',
        description: '+0.05 ECTS per click',
        emoji: '☕',
        basePrice: 60,
        effect: '+0.05/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'friend',
        name: 'Friend (auto click)',
        description: '+0.5 ECTS per second',
        emoji: '👥',
        basePrice: 150,
        effect: '+0.5/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'tutor',
        name: 'Private Tutor',
        description: '+2 ECTS per second',
        emoji: '🧑‍🏫',
        basePrice: 500,
        effect: '+2/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'earlyPass',
        name: 'Early Pass',
        description: '+10% to everything',
        emoji: '📝',
        basePrice: 1200,
        effect: '+10% multi',
        type: UpgradeType.multiplier,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'dissertation',
        name: 'Master\'s Thesis',
        description: '+5 ECTS per second',
        emoji: '📄',
        basePrice: 2500,
        effect: '+5/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Magister',
      ),
      Upgrade(
        id: 'scientificArticle',
        name: 'Scientific Article',
        description: '+0.5 ECTS per click',
        emoji: '📰',
        basePrice: 2000,
        effect: '+0.5/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Magister',
      ),
      Upgrade(
        id: 'conference',
        name: 'Conference',
        description: '+20% to everything',
        emoji: '🎤',
        basePrice: 5000,
        effect: '+20% multi',
        type: UpgradeType.multiplier,
        requiredEducationLevel: 'Magister',
      ),
      Upgrade(
        id: 'grant',
        name: 'Research Grant',
        description: '+10 ECTS per second',
        emoji: '💰',
        basePrice: 12000,
        effect: '+10/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Doktorant',
      ),
      Upgrade(
        id: 'laboratory',
        name: 'Own Laboratory',
        description: '+1 ECTS per click',
        emoji: '🔬',
        basePrice: 10000,
        effect: '+1/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Doktorant',
      ),
      Upgrade(
        id: 'publisher',
        name: 'Publisher',
        description: '+30% to everything',
        emoji: '📚',
        basePrice: 25000,
        effect: '+30% multi',
        type: UpgradeType.multiplier,
        requiredEducationLevel: 'Doktorant',
      ),
    ];
  }

  static List<Upgrade> getUpgradesForLevel(String educationLevel) {
    final allLevels = ['Licencjat', 'Magister', 'Doktorant', 'Profesor'];
    final currentIndex = allLevels.indexOf(educationLevel);

    return getAllUpgrades().where((upgrade) {
      final upgradeIndex = allLevels.indexOf(upgrade.requiredEducationLevel);
      return upgradeIndex <= currentIndex;
    }).toList();
  }
}
