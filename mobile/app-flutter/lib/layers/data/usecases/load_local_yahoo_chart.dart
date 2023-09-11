import 'dart:convert';

import 'package:result_dart/result_dart.dart';

import '../../../../../../commons/commons.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../cache/cache.dart';

class LoadLocalYahooChart implements LocalYahooChart {
  final SaveCacheStorage saveLocalCacheStorage;
  final DeleteCacheStorage deleteCacheStorage;
  final FetchCacheStorage fetchCacheStorage;
  final String table = 'chart';

  LoadLocalYahooChart({
    required this.saveLocalCacheStorage,
    required this.deleteCacheStorage,
    required this.fetchCacheStorage,
  });

  @override
  AsyncResult<void, CacheException> save(String key, YahooChartEntity entity) async {
    try {
      var json = toJson(entity);
      await saveLocalCacheStorage.save(table, key: key, value: json);
      return Success.unit();
    } catch (error) {
      return Failure(CacheException(error.toString()));
    }
  }

  @override
  AsyncResult<YahooChartEntity, CacheException> fetch(String key) async {
    try {
      var value = await fetchCacheStorage.fetch(table, key: key);
      if (value != null) {
        if (value is String && value.isNotNullOrEmpty()) {
          return Success(fromJson(value));
        }
      }

      return Failure(CacheException('Invalid data'));
    } catch (error) {
      return Failure(CacheException(error.toString()));
    }
  }

  @override
  AsyncResult<void, CacheException> delete(String key) async {
    try {
      await deleteCacheStorage.delete(table, key: key);
      return Success.unit();
    } catch (error) {
      return Failure(CacheException(error.toString()));
    }
  }

  String toJson(YahooChartEntity entity) {
    Map<String, dynamic> json = {
      "symbol": entity.symbol,
      "timestamp": entity.timestamp.map((e) => e.millisecondsSinceEpoch).toList(),
      "open": entity.open.toList(),
    };

    return jsonEncode(json);
  }

  YahooChartEntity fromJson(String value) {
    var json = jsonDecode(value);

    return YahooChartEntity(
      symbol: json["symbol"],
      timestamp: (json["timestamp"] as List).map((e) => DateTime.fromMillisecondsSinceEpoch(e)).toList(),
      open: (json["open"] as List).map((e) => e as double).toList(),
    );
  }
}
