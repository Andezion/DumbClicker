class GameState {
  double ects = 0.0;
  double ectsPerClick = 0.1;
  double ectsPerSecond = 0.0;
  int semester = 1;
  int totalEctsEarned = 0;
  int prestigePoints = 0;

  String educationLevel = 'Licencjat'; // Licencjat, Magister, Doktorant, Profesor
  int educationSemester = 1;
  double motivation = 100.0;
  DateTime lastMotivationUpdate = DateTime.now();
  int battlePassLevel = 0;
  int battlePassXP = 0;
  bool isPremiumBattlePass = false;
  List<String> unlockedSkins = ['default'];
  String currentSkin = 'default';
  DateTime? lastEventTime;

  Map<String, int> upgrades = {
    'laptop': 0,
    'coffee': 0,
    'friend': 0,
    'tutor': 0,
    'earlyPass': 0,

    'dissertation': 0,
    'scientificArticle': 0,
    'conference': 0,

    'grant': 0,
    'laboratory': 0,
    'publisher': 0,
  };

  int getRequiredEcts() {
    switch (educationLevel) {
      case 'Licencjat':
        return 30;
      case 'Magister':
        return 40;
      case 'Doktorant':
        return 60;
      case 'Profesor':
        return 100;
      default:
        return 30;
    }
  }

  int getTotalSemestersForLevel() {
    switch (educationLevel) {
      case 'Licencjat':
        return 7;
      case 'Magister':
        return 4;
      case 'Doktorant':
        return 4;
      case 'Profesor':
        return 999;
      default:
        return 7;
    }
  }

  Map<String, dynamic> toJson() => {
    'ects': ects,
    'ectsPerClick': ectsPerClick,
    'ectsPerSecond': ectsPerSecond,
    'semester': semester,
    'totalEctsEarned': totalEctsEarned,
    'prestigePoints': prestigePoints,
    'educationLevel': educationLevel,
    'educationSemester': educationSemester,
    'motivation': motivation,
    'lastMotivationUpdate': lastMotivationUpdate.toIso8601String(),
    'battlePassLevel': battlePassLevel,
    'battlePassXP': battlePassXP,
    'isPremiumBattlePass': isPremiumBattlePass,
    'unlockedSkins': unlockedSkins,
    'currentSkin': currentSkin,
    'lastEventTime': lastEventTime?.toIso8601String(),
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
    state.educationLevel = json['educationLevel'] ?? 'Licencjat';
    state.educationSemester = json['educationSemester'] ?? 1;
    state.motivation = json['motivation'] ?? 100.0;
    state.lastMotivationUpdate = json['lastMotivationUpdate'] != null
        ? DateTime.parse(json['lastMotivationUpdate'])
        : DateTime.now();
    state.battlePassLevel = json['battlePassLevel'] ?? 0;
    state.battlePassXP = json['battlePassXP'] ?? 0;
    state.isPremiumBattlePass = json['isPremiumBattlePass'] ?? false;
    state.unlockedSkins = List<String>.from(json['unlockedSkins'] ?? ['default']);
    state.currentSkin = json['currentSkin'] ?? 'default';
    state.lastEventTime = json['lastEventTime'] != null
        ? DateTime.parse(json['lastEventTime'])
        : null;
    state.upgrades = Map<String, int>.from(json['upgrades'] ?? state.upgrades);
    return state;
  }
}