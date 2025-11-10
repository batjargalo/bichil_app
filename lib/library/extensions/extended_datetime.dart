import 'package:intl/intl.dart';

extension ExtendedDate on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  String toFormattedString({
    required String format,
    bool hasLocalTimeZone = true,
  }) {
    final value = hasLocalTimeZone ? toLocal() : this;
    return DateFormat(format).format(value);
  }
}
