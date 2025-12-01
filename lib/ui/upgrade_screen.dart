import 'package:flutter/material.dart';
import '../model/game_state.dart';
import '../model/upgrade.dart';
import '../widgets/upgrade_card.dart';

class UpgradesScreen extends StatelessWidget {
  final GameState gameState;
  final Function(Upgrade) onUpgradeBuy;

  const UpgradesScreen({
    super.key,
    required this.gameState,
    required this.onUpgradeBuy,
  });

  @override
  Widget build(BuildContext context) {
    final availableUpgrades =
        Upgrade.getUpgradesForLevel(gameState.educationLevel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Sklep'),
        backgroundColor: const Color(0xFF0f3460),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade700, Colors.purple.shade700],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  '${_getEducationEmoji()} ${gameState.educationLevel}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Dostępne apgrady: ${availableUpgrades.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Dostępne apgrady',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...availableUpgrades.map((upgrade) {
            return UpgradeCard(
              upgrade: upgrade,
              currentLevel: gameState.upgrades[upgrade.id] ?? 0,
              currentCurrency: gameState.tokens.toDouble(),
              onBuy: () => onUpgradeBuy(upgrade),
            );
          }),
          const SizedBox(height: 20),
          if (gameState.educationLevel != 'Profesor')
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Column(
                children: [
                  const Icon(Icons.lock, color: Colors.grey, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    'Ukończ ${gameState.educationLevel} aby odblokować więcej!',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _getEducationEmoji() {
    switch (gameState.educationLevel) {
      case 'Licencjat':
        return '🎓';
      case 'Magister':
        return '📚';
      case 'Doktorant':
        return '🔬';
      case 'Profesor':
        return '👨‍🏫';
      default:
        return '🎓';
    }
  }
}
