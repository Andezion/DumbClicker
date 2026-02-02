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
        description: 'Unexpected kolokwium! Pay 10 ECTS or lose motivation.',
        emoji: '📝',
        type: EventType.negative,
        ectsCost: 10,
        motivationChange: -20,
      ),
      RandomEvent(
        id: 'oversleep',
        title: 'Overslept!',
        description: 'You overslept through the lecture. -10% motivation.',
        emoji: '😴',
        type: EventType.negative,
        motivationChange: -10,
      ),
      RandomEvent(
        id: 'professor_caught',
        title: 'Professor caught you!',
        description: 'The professor caught you cheating. -15% motivation.',
        emoji: '🏫',
        type: EventType.negative,
        motivationChange: -15,
      ),
      RandomEvent(
        id: 'laptop_broken',
        title: 'Laptop broke down!',
        description:
            'Laptop broke down before the deadline. Pay 15 ECTS for repairs.',
        emoji: '💻🔧',
        type: EventType.negative,
        ectsCost: 15,
        motivationChange: -5,
      ),
      RandomEvent(
        id: 'scholarship',
        title: 'Scholarship!',
        description: 'You received a scholarship! +50 ECTS!',
        emoji: '💰',
        type: EventType.positive,
        ectsCost: -50,
      ),
      RandomEvent(
        id: 'good_grade',
        title: 'Good Grade!',
        description:
            'You got a good grade on a difficult exam! +15% motivation.',
        emoji: '⭐',
        type: EventType.positive,
        motivationChange: 15,
      ),
      RandomEvent(
        id: 'coffee_break',
        title: 'Coffee Break',
        description: 'Time for coffee! +8 motivation.',
        emoji: '☕',
        type: EventType.positive,
        motivationChange: 8,
      ),
      RandomEvent(
        id: 'friend_help',
        title: 'Friend Helped!',
        description: 'A friend shared notes with you. +10 ECTS!',
        emoji: '🤝',
        type: EventType.positive,
        ectsCost: -10,
      ),
      RandomEvent(
        id: 'easy_exam',
        title: 'Easy Exam!',
        description: 'The exam was easier than you thought. +20 ECTS!',
        emoji: '🎉',
        type: EventType.positive,
        ectsCost: -20,
        motivationChange: 10,
      ),
      RandomEvent(
        id: 'lucky_day',
        title: 'Lucky Day!',
        description: 'Everything is going great! +5% motivation.',
        emoji: '🍀',
        type: EventType.positive,
        motivationChange: 5,
      ),
      RandomEvent(
        id: 'study_group',
        title: 'Study Group',
        description: 'Effective study session with a group! +15 ECTS.',
        emoji: '📚',
        type: EventType.positive,
        ectsCost: -15,
      ),
      RandomEvent(
        id: 'party_night',
        title: 'Party Night!',
        description:
            'Friends invite you to a party. Go and gain motivation (+25), but lose 15 ECTS.',
        emoji: '🎊',
        type: EventType.neutral,
        ectsCost: 15,
        motivationChange: 25,
      ),
      RandomEvent(
        id: 'extra_project',
        title: 'Extra Project',
        description:
            'The professor offers an extra project. It costs 20 ECTS time, but gives experience.',
        emoji: '📊',
        type: EventType.neutral,
        ectsCost: 20,
        motivationChange: 5,
      ),
    ];
  }
}
