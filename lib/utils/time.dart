class Time {
  // 当前时间
  static final DateTime now = DateTime.now();

  static final DateTime today = DateTime(now.year, now.month, now.day);
  static final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
  static final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

  static String formatTime(DateTime timeDate) {
    // print(time.isUtc);
    // time.toLocal;
    final DateTime time = timeDate.isUtc ? timeDate.toLocal() : timeDate;
    final String monthDay = '${time.month}/${time.day}';
    final String hourMinute = '${time.hour < 10 ? '0'+ time.hour.toString() : time.hour.toString()}:${time.minute < 10 ? '0'+ time.minute.toString() : time.minute.toString()}';
    final DateTime aDate = DateTime(time.year, time.month, time.day);
    // print(aDate.toString());
    if (aDate == today) {
      return hourMinute;
    } else if (aDate == yesterday) {
      return '昨天 $hourMinute';
    } else {
      return '$monthDay $hourMinute';
    }
  }
}
