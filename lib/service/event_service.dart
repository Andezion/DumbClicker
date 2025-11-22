import 'dart:async';
import 'dart:math';
import '../model/game_state.dart';
import '../model/random_event.dart';

class EventService {
  static Timer? _eventTimer;
  static const Duration minEventInterval = Duration(seconds: 30);
  static const Duration maxEventInterval = Duration(seconds: 90);

  static void startEventGeneration(
      GameState gameState, Function(RandomEvent) onEventTriggered) {
    _eventTimer?.cancel();
    _scheduleNextEvent(gameState, onEventTriggered);
  }

  static void _scheduleNextEvent(
      GameState gameState, Function(RandomEvent) onEventTriggered) {
    final random = Random();
    final secondsUntilNext = minEventInterval.inSeconds +
        random.nextInt(maxEventInterval.inSeconds - minEventInterval.inSeconds);

    _eventTimer = Timer(Duration(seconds: secondsUntilNext), () {
      final event = _getRandomEvent();
      gameState.lastEventTime = DateTime.now();
      onEventTriggered(event);

      _scheduleNextEvent(gameState, onEventTriggered);
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
      gameState.motivation =
          (gameState.motivation + event.motivationChange).clamp(0, 100.0);
    }
  }
}
