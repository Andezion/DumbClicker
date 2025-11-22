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
        name: 'Licencjat (Bachelor)',
        emoji: '🎓',
        totalSemesters: 7,
        ectsPerSemester: 30,
        description: 'Podstawowe studia. Idealny start!',
        unlockedUpgrades: ['laptop', 'coffee', 'friend', 'tutor', 'earlyPass'],
      ),
      EducationLevel(
        id: 'Magister',
        name: 'Magister (Master)',
        emoji: '📚',
        totalSemesters: 4,
        ectsPerSemester: 40,
        description: 'Studia magisterskie. +20% trudności, nowe apgrady!',
        unlockedUpgrades: ['dissertation', 'scientificArticle', 'conference'],
      ),
      EducationLevel(
        id: 'Doktorant',
        name: 'Doktorant (PhD)',
        emoji: '🔬',
        totalSemesters: 4,
        ectsPerSemester: 60,
        description: 'Doktorat. +50% trudności. Tylko dla hardcore graczy!',
        unlockedUpgrades: ['grant', 'laboratory', 'publisher'],
      ),
      EducationLevel(
        id: 'Profesor',
        name: 'Profesor (Professor)',
        emoji: '👨‍🏫',
        totalSemesters: 999,
        ectsPerSemester: 100,
        description: 'Endless mode. Prestiż i chwała!',
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