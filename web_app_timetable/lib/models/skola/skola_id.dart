class SkolaId {
  final int value;

  SkolaId({
    required this.value,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SkolaId && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
