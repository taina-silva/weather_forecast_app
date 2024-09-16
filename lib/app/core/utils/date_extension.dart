extension DateExtension on DateTime {
  bool isAtSameDayOfString(String other) {
    try {
      int otherYear = int.parse(other.split('-')[0]);
      int otherMonth = int.parse(other.split('-')[1]);
      int otherDay = int.parse(other.split('-')[2]);

      return year == otherYear && month == otherMonth && day == otherDay;
    } catch (_) {
      throw Exception('Invalid date format');
    }
  }

  String get monthNameLong => _monthslong[month]!;

  String get monthNameShort => _monthsShort[month]!;

  String get prettyDayNumber => day < 10 ? '0$day' : '$day';

  String get prettyMonthNumber => month < 10 ? '0$month' : '$month';

  static const Map<int, String> _monthslong = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
  };

  static const Map<int, String> _monthsShort = {
    1: 'Jan',
    2: 'Fev',
    3: 'Mar',
    4: 'Abr',
    5: 'Mai',
    6: 'Jun',
    7: 'Jul',
    8: 'Ago',
    9: 'Set',
    10: 'Out',
    11: 'Nov',
    12: 'Dez',
  };
}
