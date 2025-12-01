import 'package:flutter/material.dart';
import '../model/game_state.dart';

class AchievementsScreen extends StatelessWidget {
  final GameState gameState;

  const AchievementsScreen({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 Achievements'),
        backgroundColor: const Color(0xFF0f3460),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trophies: ${gameState.trophies}',
                    style: const TextStyle(fontSize: 18)),
                Text('Tap x${gameState.tapMultiplier.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Medals:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Expanded(
              child: gameState.medals.isEmpty
                  ? const Center(
                      child: Text(
                          'No medals yet. Complete semesters to earn them.'),
                    )
                  : ListView.builder(
                      itemCount: gameState.medals.length,
                      itemBuilder: (context, index) {
                        final id = gameState.medals[index];
                        return Card(
                          color: Colors.indigo.shade800,
                          child: ListTile(
                            leading: const Icon(Icons.emoji_events,
                                color: Colors.amber),
                            title: Text(id,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
