enum EventType {
  positive,
  negative,
  neutral,
}

class RandomEvent {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final EventType type;
  final double ectsCost;
  final double motivationChange;
  final Duration? duration;
  final Function(dynamic gameState)? effect;

  RandomEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.type,
    this.ectsCost = 0,
    this.motivationChange = 0,
    this.duration,
    this.effect,
  });

  static List<RandomEvent> getAllEvents() {
    return [
      RandomEvent(
        id: 'kolokwium',
        title: 'Kolokwium!',
        description: 'Niespodziewane kolokwium! Zapłać 10 ECTS lub zgub motywację.',
        emoji: '📝',
        type: EventType.negative,
        ectsCost: 10,
        motivationChange: -20,
      ),
      RandomEvent(
        id: 'oversleep',
        title: 'Zaspałeś!',
        description: 'Spałeś przez wykład. -50% dochodu na 5 minut.',
        emoji: '😴',
        type: EventType.negative,
        motivationChange: -15,
        duration: Duration(minutes: 5),
      ),
      RandomEvent(
        id: 'profesor_zlapal',
        title: 'Profesor złapał!',
        description: 'Profesor przyłapał cię na ściąganiu. Brak passive income na 10 minut.',
        emoji: '🏫',
        type: EventType.negative,
        duration: Duration(minutes: 10),
      ),
      RandomEvent(
        id: 'party_night',
        title: 'Impreza!',
        description: 'Znajomi zapraszają na imprezę. Idź i zyskaj motywację (+30), ale strać 20 ECTS.',
        emoji: '🎉',
        type: EventType.neutral,
        ectsCost: 20,
        motivationChange: 30,
      ),
      RandomEvent(
        id: 'scholarship',
        title: 'Stypendium!',
        description: 'Dostałeś stypendium! +50 ECTS!',
        emoji: '💰',
        type: EventType.positive,
        ectsCost: -50,
      ),
      RandomEvent(
        id: 'good_grade',
        title: 'Piątka!',
        description: 'Dostałeś piątkę z trudnego egzaminu! +10% motywacji.',
        emoji: '⭐',
        type: EventType.positive,
        motivationChange: 10,
      ),
      RandomEvent(
        id: 'coffee_break',
        title: 'Przerwa na kawę',
        description: 'Czas na kawę! +5 motywacji.',
        emoji: '☕',
        type: EventType.positive,
        motivationChange: 5,
      ),
    ];
  }
}