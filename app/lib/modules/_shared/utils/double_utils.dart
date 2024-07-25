import '../utils/string_utils.dart';

class DoubleUtils {
  static double? toDouble(dynamic value) {
    if (value is String) {
      return StringUtils.toDouble(value);
    } else if (value is num) {
      return value.toDouble();
    } else {
      return null;
    }
  }
}
