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
        id: 'Bachelor',
        name: 'Bachelor',
        emoji: '🎓',
        totalSemesters: 7,
        ectsPerSemester: 30,
        description: 'Basic studies. Ideal start!',
        unlockedUpgrades: ['laptop', 'coffee', 'friend', 'tutor', 'earlyPass'],
      ),
      EducationLevel(
        id: 'Master',
        name: 'Master',
        emoji: '📚',
        totalSemesters: 4,
        ectsPerSemester: 40,
        description: 'Master studies. +20% difficulty, new upgrades!',
        unlockedUpgrades: ['dissertation', 'scientificArticle', 'conference'],
      ),
      EducationLevel(
        id: 'PhD',
        name: 'PhD',
        emoji: '🔬',
        totalSemesters: 4,
        ectsPerSemester: 60,
        description: 'PhD studies. +50% difficulty. Only for hardcore players!',
        unlockedUpgrades: ['grant', 'laboratory', 'publisher'],
      ),
      EducationLevel(
        id: 'Professor',
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
      case 'Bachelor':
        return 'Master';
      case 'Master':
        return 'PhD';
      case 'PhD':
        return 'Professor';
      default:
        return 'Professor';
    }
  }
}
