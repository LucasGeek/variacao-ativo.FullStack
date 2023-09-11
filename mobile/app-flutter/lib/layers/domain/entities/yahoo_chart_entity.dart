class YahooChartEntity {
  final String symbol;
  final List<DateTime> timestamp;
  final List<double> open;

  const YahooChartEntity({
    required this.symbol,
    required this.timestamp,
    required this.open,
  });
}
