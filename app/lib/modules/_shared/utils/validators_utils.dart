import 'package:intl/intl.dart';
import '../utils/string_utils.dart';

class Validators {
  static bool isPasswordValid(String password) {
    final hasSixNumbers = RegExp(
      '^(?=.*[0-9].*[0-9].*[0-9].*[0-9].*[0-9].*[0-9]).{6}\$',
    ).hasMatch(password);

    return hasSixNumbers && !isSequential(password);
  }

  static bool isBarcodeValid(String barcode) {
    final unmasked = StringUtils.unmask(barcode).replaceAll(' ', '').trim();
    return RegExp('^\\d{47,48}\$').hasMatch(unmasked);
  }

  static bool isSequential(String str) {
    for (var i = 0; i < str.length - 1; i++) {
      final current = str.codeUnitAt(i);
      final next = str.codeUnitAt(i + 1);

      if ((next - current).abs() > 1) {
        return false;
      }
    }

    return true;
  }

  static bool isEmail(String value) {
    return RegExp('[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}')
        .hasMatch(value);
  }

  static bool isPhone(String value) {
    var str = StringUtils.unmask(value);
    str = str.replaceAll(' ', '');
    str = str.replaceAll('+', '');
    return RegExp(r'^[0-9]{11,13}$').hasMatch(str);
  }

  static bool isCep(String value) {
    var str = StringUtils.unmask(value);
    str = str.replaceAll(' ', '');
    str = str.replaceAll('+', '');
    return RegExp(r'^[0-9]{8}$').hasMatch(str);
  }

  static bool isPastDate(String value) {
    try {
      final date = DateFormat('dd/MM/yyyy').parse(value);

      return date.day <= 31 &&
          date.month <= 12 &&
          date.isBefore(DateTime.now());
    } catch (error) {
      return false;
    }
  }

  static bool isDate(String value) {
    try {
      final date = DateFormat('dd/MM/yyyy').parse(value);

      return date.day <= 31 && date.month <= 12;
    } catch (error) {
      return false;
    }
  }

  static bool isCpf(String? value) {
    if (value == null) return false;

    var numbers = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (numbers.length != 11) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) return false;

    var digits = numbers.split('').map((String d) => int.parse(d)).toList();

    var calcDv1 = 0;
    for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digits[10 - i] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digits[9] != dv1) return false;

    var calcDv2 = 0;
    for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digits[11 - i] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digits[10] != dv2) return false;

    return true;
  }

  static bool isCnpj(String? value) {
    if (value == null) return false;

    var numbers = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (numbers.length != 14) return false;

    if (RegExp(r'^(\d)\1*$').hasMatch(numbers)) return false;

    var digits = numbers.split('').map((String d) => int.parse(d)).toList();

    var calcDv1 = 0;
    var j = 0;
    for (var i in Iterable<int>.generate(12, (i) => i < 4 ? 5 - i : 13 - i)) {
      calcDv1 += digits[j++] * i;
    }
    calcDv1 %= 11;
    var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

    if (digits[12] != dv1) return false;

    var calcDv2 = 0;
    j = 0;
    for (var i in Iterable<int>.generate(13, (i) => i < 5 ? 6 - i : 14 - i)) {
      calcDv2 += digits[j++] * i;
    }
    calcDv2 %= 11;
    var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

    if (digits[13] != dv2) return false;

    return true;
  }

  static bool isCreditCardNumberValid(String value) {
    String _getCleanedNumber(String number) {
      var regExp = RegExp(r'[^0-9]');
      return number.replaceAll(regExp, '');
    }

    value = _getCleanedNumber(value);

    if (value.length < 16) {
      return false;
    }

    var sum = 0;
    var length = value.length;
    for (var i = 0; i < length; i++) {
      var digit = int.parse(value[length - i - 1]);
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return true;
    }

    return false;
  }

  static bool isCreditCardDateValid(String value) {
    int _convertYearTo4Digits(int year) {
      if (year < 100 && year >= 0) {
        var now = DateTime.now();
        var currentYear = now.year.toString();
        var prefix = currentYear.substring(0, currentYear.length - 2);
        year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
      }
      return year;
    }

    bool _hasYearPassed(int year) {
      var fourDigitsYear = _convertYearTo4Digits(year);
      var now = DateTime.now();
      return fourDigitsYear < now.year;
    }

    bool _hasMonthPassed(int year, int month) {
      var now = DateTime.now();
      return _hasYearPassed(year) ||
          _convertYearTo4Digits(year) == now.year && (month < now.month + 1);
    }

    bool _isNotExpired(int year, int month) {
      return !_hasYearPassed(year) && !_hasMonthPassed(year, month);
    }

    bool _hasDateExpired(int month, int year) {
      return _isNotExpired(year, month);
    }

    if (value.isEmpty) {
      return false;
    }

    int year;
    int month;

    if (value.contains(RegExp(r'(\/)'))) {
      var split = value.split(RegExp(r'(\/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }

    if ((month < 1) || (month > 12)) {
      return false;
    }

    var fourDigitsYear = _convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      return false;
    }

    if (!_hasDateExpired(month, year)) {
      return false;
    }
    return true;
  }
}
