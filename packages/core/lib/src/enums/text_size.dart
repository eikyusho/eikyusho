enum TextSize {
  /// Font size: 12, Line height: 14
  xs(12, 14),

  /// Font size: 14, Line height: 20
  sm(14, 20),

  /// Font size: 16, Line height: 20
  md(16, 20),

  /// Font size: 18, Line height: 24
  lg(18, 24),

  /// Font size: 20, Line height: 28
  xl(20, 28),

  /// Font size: 24, Line height: 32
  $2xl(24, 32),

  /// Font size: 30, Line height: 40
  $3xl(30, 40);

  const TextSize(this.value, this._height);

  final double value;
  final double _height;

  double get height => _height / value;
}
