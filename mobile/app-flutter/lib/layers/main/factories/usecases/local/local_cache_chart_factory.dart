import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../factories.dart';

LocalYahooChart makeRemoteCacheYahooChartFactory() => LoadLocalYahooChart(
      saveLocalCacheStorage: makeLocalStorageAdapter(),
      fetchCacheStorage: makeLocalStorageAdapter(),
      deleteCacheStorage: makeLocalStorageAdapter(),
    );
