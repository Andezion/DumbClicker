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
        name: 'Nowy Laptop',
        description: '+0.1 ECTS za klik',
        emoji: '💻',
        basePrice: 10,
        effect: '+0.1/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'coffee',
        name: 'Kawa na Noc',
        description: '+0.05 ECTS za klik',
        emoji: '☕',
        basePrice: 25,
        effect: '+0.05/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'friend',
        name: 'Przyjaciel (autoklik)',
        description: '+0.5 ECTS/sek',
        emoji: '👥',
        basePrice: 50,
        effect: '+0.5/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'tutor',
        name: 'Prywatny Korepetytor',
        description: '+2 ECTS/sek',
        emoji: '🧑‍🏫',
        basePrice: 200,
        effect: '+2/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Licencjat',
      ),
      Upgrade(
        id: 'earlyPass',
        name: 'Zaliczenie Wcześniej',
        description: '+10% do wszystkiego',
        emoji: '📝',
        basePrice: 500,
        effect: '+10% multi',
        type: UpgradeType.multiplier,
        requiredEducationLevel: 'Licencjat',
      ),

      Upgrade(
        id: 'dissertation',
        name: 'Praca Magisterska',
        description: '+5 ECTS/sek',
        emoji: '📄',
        basePrice: 1000,
        effect: '+5/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Magister',
      ),
      Upgrade(
        id: 'scientificArticle',
        name: 'Artykuł Naukowy',
        description: '+0.5 ECTS za klik',
        emoji: '📰',
        basePrice: 800,
        effect: '+0.5/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Magister',
      ),
      Upgrade(
        id: 'conference',
        name: 'Konferencja',
        description: '+20% do wszystkiego',
        emoji: '🎤',
        basePrice: 2000,
        effect: '+20% multi',
        type: UpgradeType.multiplier,
        requiredEducationLevel: 'Magister',
      ),

      Upgrade(
        id: 'grant',
        name: 'Grant Naukowy',
        description: '+10 ECTS/sek',
        emoji: '💰',
        basePrice: 5000,
        effect: '+10/sec',
        type: UpgradeType.autoClick,
        requiredEducationLevel: 'Doktorant',
      ),
      Upgrade(
        id: 'laboratory',
        name: 'Własne Laboratorium',
        description: '+1 ECTS za klik',
        emoji: '🔬',
        basePrice: 4000,
        effect: '+1/click',
        type: UpgradeType.clickBoost,
        requiredEducationLevel: 'Doktorant',
      ),
      Upgrade(
        id: 'publisher',
        name: 'Wydawnictwo',
        description: '+30% do wszystkiego',
        emoji: '📚',
        basePrice: 10000,
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