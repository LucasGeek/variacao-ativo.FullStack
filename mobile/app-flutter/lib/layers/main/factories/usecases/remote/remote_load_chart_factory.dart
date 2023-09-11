import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../factories.dart';

RemoteYahooChart makeRemoteLoadYahooChartFactory() => LoadRemoteYahooChart(
      httpClient: makeHttpAdapter(),
      url: 'v8/finance/chart',
    );
