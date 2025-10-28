class Formatters {
  static String formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else {
      return number.toStringAsFixed(1);
    }
  }

  static String formatEcts(double ects) {
    return ects.toStringAsFixed(1);
  }

  static String formatPerSecond(double rate) {
    return '+${rate.toStringAsFixed(2)}/s';
  }

  static String formatPerClick(double rate) {
    return '+${rate.toStringAsFixed(2)}';
  }

  static String formatPrice(double price) {
    return price.toStringAsFixed(0);
  }
}