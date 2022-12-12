class NastavnikId {
  final int value;

  NastavnikId({
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
    return other is NastavnikId && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
