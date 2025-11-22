import 'dart:async';
import '../model/game_state.dart';

class MotivationService {
  static const double motivationDecayPerHour = 8.0;
  static const double minMotivation = 10.0;

  static Timer? _motivationTimer;

  static void startMotivationDecay(
      GameState gameState, Function(GameState) onUpdate) {
    _motivationTimer?.cancel();

    _motivationTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      final minutesPassed =
          now.difference(gameState.lastMotivationUpdate).inMinutes;

      if (minutesPassed > 0) {
        final decay = (motivationDecayPerHour / 60) * minutesPassed;

        final lowMotivationPenalty = gameState.motivation < 30 ? 1.5 : 1.0;
        final finalDecay = decay * lowMotivationPenalty;

        gameState.motivation =
            (gameState.motivation - finalDecay).clamp(minMotivation, 100.0);
        gameState.lastMotivationUpdate = now;
        onUpdate(gameState);
      }
    });
  }

  static void stopMotivationDecay() {
    _motivationTimer?.cancel();
  }

  static double getMotivationMultiplier(double motivation) {
    return motivation / 100.0;
  }

  static void restoreMotivation(GameState gameState, double amount) {
    gameState.motivation = (gameState.motivation + amount).clamp(0, 100.0);
  }

  static String getMotivationStatus(double motivation) {
    if (motivation >= 80) return '😊 Świetna forma!';
    if (motivation >= 60) return '🙂 W porządku';
    if (motivation >= 40) return '😐 Zmęczony';
    if (motivation >= 20) return '😞 Depresja';
    return '💀 Wypalenie';
  }
}
