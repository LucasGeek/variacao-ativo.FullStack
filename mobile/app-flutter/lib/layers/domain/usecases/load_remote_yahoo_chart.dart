import 'package:result_dart/result_dart.dart';

import '../../../../../commons/commons.dart';
import '../domain.dart';

abstract class RemoteYahooChart {
  Future<Result<YahooChartEntity, FailureException>> fetch(String symbol, {required LoadYahooChartParams params});
}

class LoadYahooChartParams {
  LoadYahooChartParams({
    required this.periodOne,
    required this.periodTwo,
    required this.interval,
  });

  final int periodOne;
  final int periodTwo;
  final String interval;

  Map<String, dynamic> toMap() => {
        'period1': periodOne,
        'period2': periodTwo,
        'interval': interval,
      };
}
