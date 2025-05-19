enum WidgetState {
  idle,
  loading,
  success,
  error,
  empty,
  hide;

  factory WidgetState.getByName(String? name) => values.firstWhere(
        (e) => e.name == name,
        orElse: () => WidgetState.hide,
      );
}
