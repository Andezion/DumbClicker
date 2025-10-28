class GameState {
  GameState();

  double ects = 0.0;
  double ectsPerClick = 0.1;
  double ectsPerSecond = 0.0;
  int semester = 1;
  int totalEctsEarned = 0;
  int prestigePoints = 0;

  Map<String, int> upgrades = {
    'laptop': 0,
    'coffee': 0,
    'friend': 0,
    'tutor': 0,
    'earlyPass': 0,
  };

  Map<String, dynamic> toJson() => {
    'ects': ects,
    'ectsPerClick': ectsPerClick,
    'ectsPerSecond': ectsPerSecond,
    'semester': semester,
    'totalEctsEarned': totalEctsEarned,
    'prestigePoints': prestigePoints,
    'upgrades': upgrades,
  };

  factory GameState.fromJson(Map<String, dynamic> json) {
    final state = GameState();
    state.ects = json['ects'] ?? 0.0;
    state.ectsPerClick = json['ectsPerClick'] ?? 0.1;
    state.ectsPerSecond = json['ectsPerSecond'] ?? 0.0;
    state.semester = json['semester'] ?? 1;
    state.totalEctsEarned = json['totalEctsEarned'] ?? 0;
    state.prestigePoints = json['prestigePoints'] ?? 0;
    state.upgrades = Map<String, int>.from(json['upgrades'] ?? state.upgrades);
    return state;
  }
}