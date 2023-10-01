extension DateTimeExtension on DateTime {
  // TODO: this is too low quality

  static String _now(bool short) => short
      ? 'now'
      : 'now';
  static String _1SecondAgo(bool short) => short
      ? '1s'
      : '1 second ago';
  static String _nSecondsAgo(int n, bool short) => short
      ? '${n}s'
      : '$n seconds ago';
  static String _1MinuteAgo(bool short) => short
      ? '1m'
      : '1 minute ago';
  static String _nMinutesAgo(int n, bool short) => short
      ? '${n}m'
      : '$n minutes ago';
  static String _1HourAgo(bool short) => short
      ? '1h'
      : '1 hour ago';
  static String _nHoursAgo(int n, bool short) => short
      ? '${n}h'
      : '$n hours ago';
  static String _1DayAgo(bool short) => short
      ? '1d'
      : '1 day ago';
  static String _nDaysAgo(int n, bool short) => short
      ? '${n}d'
      : '$n days ago';
  static String _1MonthAgo(bool short) => short
      ? '1mo'
      : '1 month ago';
  static String _nMonthsAgo(int n, bool short) => short
      ? '${n}mo'
      : '$n months ago';
  static String _1YearAgo(bool short) => short
      ? '1y'
      : '1 year ago';
  static String _nYearsAgo(int n, bool short) => short
      ? '${n}y'
      : '$n years ago';

  String toStringFromNow({bool short = false}) {
    return toStringFrom(DateTime.now(), short: short);
  }

  String toStringFrom(DateTime other, {bool short = false}) {
    if (this == other || this.isAtSameMomentAs(other)) {
      return DateTimeExtension._now(short);
    }

    assert(this.isBefore(other));
    Duration duration = other.difference(this);

    int durationInDays = duration.inDays;
    int durationInMonths = durationInDays ~/ 30;
    int durationInYears = durationInDays ~/ 365;
    if (durationInYears == 1) {
      return DateTimeExtension._1YearAgo(short);
    }
    if (durationInYears > 1) {
      return DateTimeExtension._nYearsAgo(durationInYears, short);
    }
    if (durationInMonths == 1) {
      return DateTimeExtension._1MonthAgo(short);
    }
    if (durationInMonths > 1) {
      return DateTimeExtension._nMonthsAgo(durationInMonths, short);
    }
    if (durationInDays == 1) {
      return DateTimeExtension._1DayAgo(short);
    }
    if (durationInDays > 1) {
      return DateTimeExtension._nDaysAgo(durationInDays, short);
    }
    if (duration.inHours == 1) {
      return DateTimeExtension._1HourAgo(short);
    }
    if (duration.inHours > 1) {
      return DateTimeExtension._nHoursAgo(duration.inHours, short);
    }
    if (duration.inMinutes == 1) {
      return DateTimeExtension._1MinuteAgo(short);
    }
    if (duration.inMinutes > 1) {
      return DateTimeExtension._nMinutesAgo(duration.inMinutes, short);
    }
    if (duration.inSeconds == 1) {
      return DateTimeExtension._1SecondAgo(short);
    }
    if (duration.inSeconds > 1) {
      return DateTimeExtension._nSecondsAgo(duration.inSeconds, short);
    }
    return DateTimeExtension._now(short);
  }
}
