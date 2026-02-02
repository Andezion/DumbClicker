class EducationLevel {
  final String id;
  final String name;
  final String emoji;
  final int totalSemesters;
  final int ectsPerSemester;
  final String description;
  final List<String> unlockedUpgrades;

  EducationLevel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.totalSemesters,
    required this.ectsPerSemester,
    required this.description,
    required this.unlockedUpgrades,
  });

  static List<EducationLevel> getAllLevels() {
    return [
      EducationLevel(
        id: 'Licencjat',
        name: 'Bachelor',
        emoji: '🎓',
        totalSemesters: 7,
        ectsPerSemester: 30,
        description: 'Basic studies. Ideal start!',
        unlockedUpgrades: ['laptop', 'coffee', 'friend', 'tutor', 'earlyPass'],
      ),
      EducationLevel(
        id: 'Magister',
        name: 'Master',
        emoji: '📚',
        totalSemesters: 4,
        ectsPerSemester: 40,
        description: 'Master studies. +20% difficulty, new upgrades!',
        unlockedUpgrades: ['dissertation', 'scientificArticle', 'conference'],
      ),
      EducationLevel(
        id: 'Doktorant',
        name: 'PhD',
        emoji: '🔬',
        totalSemesters: 4,
        ectsPerSemester: 60,
        description: 'PhD studies. +50% difficulty. Only for hardcore players!',
        unlockedUpgrades: ['grant', 'laboratory', 'publisher'],
      ),
      EducationLevel(
        id: 'Profesor',
        name: 'Professor',
        emoji: '👨‍🏫',
        totalSemesters: 999,
        ectsPerSemester: 100,
        description: 'Endless mode. Prestige and glory!',
        unlockedUpgrades: [],
      ),
    ];
  }

  static EducationLevel? getById(String id) {
    try {
      return getAllLevels().firstWhere((level) => level.id == id);
    } catch (e) {
      return null;
    }
  }

  static String getNextLevel(String currentLevel) {
    switch (currentLevel) {
      case 'Licencjat':
        return 'Magister';
      case 'Magister':
        return 'Doktorant';
      case 'Doktorant':
        return 'Profesor';
      default:
        return 'Profesor';
    }
  }
}
