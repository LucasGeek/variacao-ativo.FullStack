extension ValidDateTimeNull on DateTime? {
  bool isNotNull() => this != null;

  bool isValid() {
    if (this == null) {
      return false;
    }

    try {
      DateTime.parse(this!.toString());
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension ValidDateTime on DateTime {
  String toDDMMYYYY() {
    if (!isValid()) {
      throw Exception('Invalid date');
    }

    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString()}';
  }

  bool isValid() {
    try {
      DateTime.parse(toString());
      return true;
    } catch (e) {
      return false;
    }
  }
}
