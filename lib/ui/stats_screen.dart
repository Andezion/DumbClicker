import 'package:flutter/material.dart';
import '../model/game_state.dart';
import '../utils/formatters.dart';

class StatsScreen extends StatelessWidget {
  final GameState gameState;

  const StatsScreen({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Statystyki'),
        backgroundColor: const Color(0xFF0f3460),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              '🎓 ${gameState.educationLevel}',
              'Semestr ${gameState.educationSemester}/${gameState.getTotalSemestersForLevel()}',
              Colors.purple,
            ),
            _buildStatCard(
              '⭐ Prestige Points',
              '${gameState.prestigePoints}',
              Colors.amber,
            ),
            _buildStatCard(
              '📚 Total ECTS Earned',
              '${gameState.totalEctsEarned}',
              Colors.blue,
            ),
            _buildStatCard(
              '👆 ECTS Per Click',
              Formatters.formatPerClick(gameState.ectsPerClick),
              Colors.green,
            ),
            _buildStatCard(
              '⏱️ ECTS Per Second',
              Formatters.formatPerSecond(gameState.ectsPerSecond),
              Colors.orange,
            ),
            _buildStatCard(
              '😊 Motywacja',
              '${gameState.motivation.toStringAsFixed(1)}%',
              _getMotivationColor(gameState.motivation),
            ),
            _buildStatCard(
              '🎮 Battle Pass Level',
              '${gameState.battlePassLevel}/10',
              Colors.purple,
            ),
            const SizedBox(height: 20),
            const Text(
              '📦 Kupione Apgrady',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildUpgradesStats(),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Keep grinding! 💪',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradesStats() {
    final purchasedUpgrades =
        gameState.upgrades.entries.where((entry) => entry.value > 0).toList();

    if (purchasedUpgrades.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'Nie kupiłeś jeszcze żadnych apgradów',
            style:
                TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    return Column(
      children: purchasedUpgrades.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF2a2a4e),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getUpgradeEmoji(entry.key),
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  _getUpgradeName(entry.key),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Lv. ${entry.value}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getMotivationColor(double motivation) {
    if (motivation >= 80) return Colors.green;
    if (motivation >= 60) return Colors.lightGreen;
    if (motivation >= 40) return Colors.orange;
    if (motivation >= 20) return Colors.deepOrange;
    return Colors.red;
  }

  String _getUpgradeEmoji(String id) {
    const emojiMap = {
      'laptop': '💻',
      'coffee': '☕',
      'friend': '👥',
      'tutor': '🧑‍🏫',
      'earlyPass': '📝',
      'dissertation': '📄',
      'scientificArticle': '📰',
      'conference': '🎤',
      'grant': '💰',
      'laboratory': '🔬',
      'publisher': '📚',
    };
    return emojiMap[id] ?? '📦';
  }

  String _getUpgradeName(String id) {
    const nameMap = {
      'laptop': 'Nowy Laptop',
      'coffee': 'Kawa na Noc',
      'friend': 'Przyjaciel',
      'tutor': 'Korepetytor',
      'earlyPass': 'Zaliczenie Wcześniej',
      'dissertation': 'Praca Magisterska',
      'scientificArticle': 'Artykuł Naukowy',
      'conference': 'Konferencja',
      'grant': 'Grant Naukowy',
      'laboratory': 'Laboratorium',
      'publisher': 'Wydawnictwo',
    };
    return nameMap[id] ?? id;
  }
}
