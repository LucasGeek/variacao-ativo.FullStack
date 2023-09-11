import '../../../../commons/commons.dart';
import '../../domain/domain.dart';

class YahooChartModelRemote {
  final String symbol;
  final List<int> timestamp;
  final List<double> open;

  YahooChartModelRemote({
    required this.symbol,
    required this.timestamp,
    required this.open,
  });

  factory YahooChartModelRemote.fromJson(Map<String, dynamic> json) {
    const OtherRequestException dadosInvalidosException = OtherRequestException(0, 'Dados inválidos');

    if (!json.keys.toSet().containsAll(['result', 'error'])) {
      throw dadosInvalidosException;
    }

    if (json['result'] == null || (json['result'] as List).isEmpty) {
      throw dadosInvalidosException;
    }

    var result = json['result'][0];

    if ((result["indicators"]["quote"] as List).isEmpty) {
      throw dadosInvalidosException;
    }

    var chart = YahooChartModelRemote(
      symbol: result["meta"]["symbol"],
      timestamp: (result["timestamp"] as List).map((e) => e as int).toList(),
      open: (result["indicators"]["quote"][0]["open"] as List).map((e) => double.parse("${e ?? 0.0}")).toList(),
    );

    if (chart.open.length != chart.timestamp.length) {
      throw dadosInvalidosException;
    }

    return chart;
  }

  YahooChartEntity toEntity() => YahooChartEntity(
        symbol: symbol,
        timestamp: timestamp
            .map(
              (time) => DateTime.fromMillisecondsSinceEpoch(time * 1000),
            )
            .toList(),
        open: open,
      );
}
