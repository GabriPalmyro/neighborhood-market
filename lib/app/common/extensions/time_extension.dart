extension TimeFormatExtension on int {
  String formatSecondsToHHMM() {
    final int hours = this ~/ 3600;
    final int minutes = (this % 3600) ~/ 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  String formatSecondsToHHMMSS() {
    final int hours = this ~/ 3600;
    final int minutes = (this % 3600) ~/ 60;
    final int seconds = this % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
