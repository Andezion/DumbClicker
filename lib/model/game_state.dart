import 'education_level.dart';

class GameState {
  double ects;
  double ectsPerClick;
  double ectsPerSecond;
  int semester;
  int totalEctsEarned;
  int prestigePoints;

  String educationLevel;
  int educationSemester;
  double motivation;
  DateTime lastMotivationUpdate;
  int battlePassLevel;
  int battlePassXP;
  bool isPremiumBattlePass;
  List<String> unlockedSkins;
  String currentSkin;
  DateTime? lastEventTime;
  int totalClicks;
  bool hasReceivedStarterBonus;
  DateTime? lastDailyDealCheck;
  bool hasPurchasedDailyDeal;

  Map<String, int> upgrades;
  // New fields
  int tokens;
  List<String> medals;
  int trophies;
  double tapMultiplier;
  int ectsExchangedThisSemester;
  int maxEctsFromExchangePerSemester;

  GameState({
    this.ects = 0.0,
    this.ectsPerClick = 0.1,
    this.ectsPerSecond = 0.0,
    this.semester = 1,
    this.totalEctsEarned = 0,
    this.prestigePoints = 0,
    this.educationLevel = 'Licencjat',
    this.educationSemester = 1,
    this.motivation = 100.0,
    DateTime? lastMotivationUpdate,
    this.battlePassLevel = 0,
    this.battlePassXP = 0,
    this.isPremiumBattlePass = false,
    List<String>? unlockedSkins,
    this.currentSkin = 'default',
    this.lastEventTime,
    this.totalClicks = 0,
    this.hasReceivedStarterBonus = false,
    this.lastDailyDealCheck,
    this.hasPurchasedDailyDeal = false,
    Map<String, int>? upgrades,
    this.tokens = 0,
    List<String>? medals,
    this.trophies = 0,
    this.tapMultiplier = 1.0,
    this.ectsExchangedThisSemester = 0,
    this.maxEctsFromExchangePerSemester = 3,
  })  : lastMotivationUpdate = lastMotivationUpdate ?? DateTime.now(),
        unlockedSkins = unlockedSkins ?? ['default'],
        medals = medals ?? [],
        upgrades = upgrades ??
            {
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
    final level = EducationLevel.getById(educationLevel);
    if (level != null) return level.ectsPerSemester;
    return 30;
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
        return 999; // Endless
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
        'totalClicks': totalClicks,
        'hasReceivedStarterBonus': hasReceivedStarterBonus,
        'lastDailyDealCheck': lastDailyDealCheck?.toIso8601String(),
        'hasPurchasedDailyDeal': hasPurchasedDailyDeal,
        'upgrades': upgrades,
        'tokens': tokens,
        'medals': medals,
        'trophies': trophies,
        'tapMultiplier': tapMultiplier,
        'ectsExchangedThisSemester': ectsExchangedThisSemester,
        'maxEctsFromExchangePerSemester': maxEctsFromExchangePerSemester,
      };

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      ects: (json['ects'] ?? 0.0).toDouble(),
      ectsPerClick: (json['ectsPerClick'] ?? 0.1).toDouble(),
      ectsPerSecond: (json['ectsPerSecond'] ?? 0.0).toDouble(),
      semester: json['semester'] ?? 1,
      totalEctsEarned: json['totalEctsEarned'] ?? 0,
      prestigePoints: json['prestigePoints'] ?? 0,
      educationLevel: json['educationLevel'] ?? 'Licencjat',
      educationSemester: json['educationSemester'] ?? 1,
      motivation: (json['motivation'] ?? 100.0).toDouble(),
      lastMotivationUpdate: json['lastMotivationUpdate'] != null
          ? DateTime.parse(json['lastMotivationUpdate'])
          : DateTime.now(),
      battlePassLevel: json['battlePassLevel'] ?? 0,
      battlePassXP: json['battlePassXP'] ?? 0,
      isPremiumBattlePass: json['isPremiumBattlePass'] ?? false,
      unlockedSkins: List<String>.from(json['unlockedSkins'] ?? ['default']),
      currentSkin: json['currentSkin'] ?? 'default',
      lastEventTime: json['lastEventTime'] != null
          ? DateTime.parse(json['lastEventTime'])
          : null,
      totalClicks: json['totalClicks'] ?? 0,
      hasReceivedStarterBonus: json['hasReceivedStarterBonus'] ?? false,
      lastDailyDealCheck: json['lastDailyDealCheck'] != null
          ? DateTime.parse(json['lastDailyDealCheck'])
          : null,
      hasPurchasedDailyDeal: json['hasPurchasedDailyDeal'] ?? false,
      medals: List<String>.from(json['medals'] ?? []),
      tokens: json['tokens'] ?? 0,
      trophies: json['trophies'] ?? 0,
      tapMultiplier: (json['tapMultiplier'] ?? 1.0).toDouble(),
      ectsExchangedThisSemester: json['ectsExchangedThisSemester'] ?? 0,
      maxEctsFromExchangePerSemester:
          json['maxEctsFromExchangePerSemester'] ?? 3,
      upgrades: Map<String, int>.from(json['upgrades'] ??
          {
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
          }),
    );
  }
}
