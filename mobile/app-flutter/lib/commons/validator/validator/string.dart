extension ValidString on String? {
  bool isNotNullOrEmpty() {
    return this?.trim().isNotEmpty ?? false;
  }
}
