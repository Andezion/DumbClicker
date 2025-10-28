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
    final upgrades = Upgrade.getAllUpgrades();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Sklep'),
        backgroundColor: const Color(0xFF0f3460),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Dostępne apgrady',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...upgrades.map((upgrade) {
            return UpgradeCard(
              upgrade: upgrade,
              currentLevel: gameState.upgrades[upgrade.id] ?? 0,
              currentEcts: gameState.ects,
              onBuy: () => onUpgradeBuy(upgrade),
            );
          }).toList(),
        ],
      ),
    );
  }
}