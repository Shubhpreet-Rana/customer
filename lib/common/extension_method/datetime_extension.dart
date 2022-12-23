extension DateTimeExtension on DateTime {
  String toDateFormat() {
    return '$year-${month.toString().padLeft(2, "0")}-${day.toString().padLeft(2, "0")}';
  }
}
