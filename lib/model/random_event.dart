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
        description:
            'Niespodziewane kolokwium! Zapłać 10 ECTS lub zgub motywację.',
        emoji: '📝',
        type: EventType.negative,
        ectsCost: 10,
        motivationChange: -20,
      ),
      RandomEvent(
        id: 'oversleep',
        title: 'Zaspałeś!',
        description: 'Spałeś przez wykład. -10% motywacji.',
        emoji: '😴',
        type: EventType.negative,
        motivationChange: -10,
      ),
      RandomEvent(
        id: 'profesor_zlapal',
        title: 'Profesor złapał!',
        description: 'Profesor przyłapał cię na ściąganiu. -15% motywacji.',
        emoji: '🏫',
        type: EventType.negative,
        motivationChange: -15,
      ),
      RandomEvent(
        id: 'laptop_broken',
        title: 'Laptop się zepsuł!',
        description:
            'Awaria laptopa przed deadline. Zapłać 15 ECTS na naprawę.',
        emoji: '💻🔧',
        type: EventType.negative,
        ectsCost: 15,
        motivationChange: -5,
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
        description: 'Dostałeś piątkę z trudnego egzaminu! +15% motywacji.',
        emoji: '⭐',
        type: EventType.positive,
        motivationChange: 15,
      ),
      RandomEvent(
        id: 'coffee_break',
        title: 'Przerwa na kawę',
        description: 'Czas na kawę! +8 motywacji.',
        emoji: '☕',
        type: EventType.positive,
        motivationChange: 8,
      ),
      RandomEvent(
        id: 'friend_help',
        title: 'Przyjaciel pomógł!',
        description: 'Kolega podzielił się notatkami. +10 ECTS!',
        emoji: '🤝',
        type: EventType.positive,
        ectsCost: -10,
      ),
      RandomEvent(
        id: 'easy_exam',
        title: 'Łatwy egzamin!',
        description: 'Egzamin był łatwiejszy niż myślałeś. +20 ECTS!',
        emoji: '🎉',
        type: EventType.positive,
        ectsCost: -20,
        motivationChange: 10,
      ),
      RandomEvent(
        id: 'lucky_day',
        title: 'Szczęśliwy dzień!',
        description: 'Wszystko idzie świetnie! +5% motywacji.',
        emoji: '🍀',
        type: EventType.positive,
        motivationChange: 5,
      ),
      RandomEvent(
        id: 'grupa_study',
        title: 'Grupa studyjna',
        description: 'Efektywna sesja z grupą! +15 ECTS.',
        emoji: '📚',
        type: EventType.positive,
        ectsCost: -15,
      ),
      RandomEvent(
        id: 'party_night',
        title: 'Impreza!',
        description:
            'Znajomi zapraszają na imprezę. Idź i zyskaj motywację (+25), ale strać 15 ECTS.',
        emoji: '🎊',
        type: EventType.neutral,
        ectsCost: 15,
        motivationChange: 25,
      ),
      RandomEvent(
        id: 'extra_project',
        title: 'Dodatkowy projekt',
        description:
            'Profesor oferuje dodatkowy projekt. Kosztuje 20 ECTS czasu, ale daje doświadczenie.',
        emoji: '📊',
        type: EventType.neutral,
        ectsCost: 20,
        motivationChange: 5,
      ),
    ];
  }
}
