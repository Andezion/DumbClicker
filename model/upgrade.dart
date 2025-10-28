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

  Upgrade({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
    required this.basePrice,
    required this.effect,
    required this.type,
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
      ),
      Upgrade(
        id: 'coffee',
        name: 'Kawa na Noc',
        description: '+0.05 ECTS za klik',
        emoji: '☕',
        basePrice: 25,
        effect: '+0.05/click',
        type: UpgradeType.clickBoost,
      ),
      Upgrade(
        id: 'friend',
        name: 'Przyjaciel (autoklik)',
        description: '+0.5 ECTS/sek',
        emoji: '👥',
        basePrice: 50,
        effect: '+0.5/sec',
        type: UpgradeType.autoClick,
      ),
      Upgrade(
        id: 'tutor',
        name: 'Prywatny Korepetytor',
        description: '+2 ECTS/sek',
        emoji: '🧑‍🏫',
        basePrice: 200,
        effect: '+2/sec',
        type: UpgradeType.autoClick,
      ),
      Upgrade(
        id: 'earlyPass',
        name: 'Zaliczenie Wcześniej',
        description: '+10% do wszystkiego',
        emoji: '📝',
        basePrice: 500,
        effect: '+10% multi',
        type: UpgradeType.multiplier,
      ),
    ];
  }
}