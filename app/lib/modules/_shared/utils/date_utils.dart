import 'package:intl/intl.dart';

import '../constants/core_strings.dart';

class DateUtils {
  static DateTime dateFormatter(String date) => DateFormat('dd/MM/yyyy HH:mm').parse(date);

  static DateTime dateFormatterJustDate(String date) => DateFormat('dd/MM/yyyy').parse(date);

  static DateTime? tryFormatDate(String? date) {
    try {
      if (date != null) {
        return dateFormatter(date);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  static String getVerboseDesc(DateTime date, DateFormat fallbackFormat) {
    if (isToday(date)) {
      return CoreStrings.dates.today;
    } else if (isYesterday(date)) {
      return CoreStrings.dates.yesterday;
    } else {
      return fallbackFormat.format(date);
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    if (now.day == date.day && now.month == date.month && now.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (yesterday.day == date.day && yesterday.month == date.month && yesterday.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  static List<DateTime> lastMonths({int monthsToReturn = 12, DateTime? since}) {
    final months = <DateTime>[];
    months.add(since ?? DateTime.now());

    // print('zzz monthsToReturn=$monthsToReturn  months.length=${months.length}');
    while (months.length < monthsToReturn) {
      final lastDate = months.last;
      months.add(DateTime(lastDate.year, lastDate.month - 1));
    }
    return months;
  }

  static List<DateTime> nextMonths({int monthsToReturn = 12, DateTime? since}) {
    final months = <DateTime>[];
    months.add(since ?? DateTime.now());
    while (months.length < monthsToReturn) {
      final lastDate = months.last;
      months.add(DateTime(lastDate.year, lastDate.month + 1));
    }
    return months;
  }

  static bool isPast(DateTime date) {
    final now = DateTime.now();
    final pastDaysDifference = DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
    if (pastDaysDifference >= 0) {
      return false;
    } else {
      return true;
    }
  }
}
