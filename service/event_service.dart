import 'dart:async';
import 'dart:math';
import '../model/game_state.dart';
import '../model/random_event.dart';

class EventService {
  static Timer? _eventTimer;
  static const Duration eventInterval = Duration(minutes: 3);

  static void startEventGeneration(GameState gameState, Function(RandomEvent) onEventTriggered) {
    _eventTimer?.cancel();

    _eventTimer = Timer.periodic(eventInterval, (timer) {
      final now = DateTime.now();

      if (gameState.lastEventTime == null ||
          now.difference(gameState.lastEventTime!).inMinutes >= 3) {

        final event = _getRandomEvent();
        gameState.lastEventTime = now;
        onEventTriggered(event);
      }
    });
  }

  static void stopEventGeneration() {
    _eventTimer?.cancel();
  }

  static RandomEvent _getRandomEvent() {
    final events = RandomEvent.getAllEvents();
    final random = Random();
    return events[random.nextInt(events.length)];
  }

  static void applyEvent(RandomEvent event, GameState gameState) {
    if (event.ectsCost != 0) {
      gameState.ects -= event.ectsCost;
      if (gameState.ects < 0) gameState.ects = 0;
    }

    if (event.motivationChange != 0) {
      gameState.motivation = (gameState.motivation + event.motivationChange).clamp(0, 100.0);
    }
  }
}