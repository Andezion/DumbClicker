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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              '🎓 Semestr',
              '${gameState.semester}',
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
            const Spacer(),
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
}