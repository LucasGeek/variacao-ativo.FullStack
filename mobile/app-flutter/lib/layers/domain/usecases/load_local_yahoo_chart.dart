import 'package:result_dart/result_dart.dart';

import '../../../../commons/commons.dart';
import '../domain.dart';

abstract class LocalYahooChart {
  AsyncResult<void, CacheException> save(String key, YahooChartEntity entity);
  AsyncResult<YahooChartEntity, CacheException> fetch(String key);
  AsyncResult<void, CacheException> delete(String key);
}
