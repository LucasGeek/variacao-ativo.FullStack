import 'package:result_dart/result_dart.dart';

import '../../../../../../commons/commons.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../data.dart';

class LoadRemoteYahooChart implements RemoteYahooChart {
  final HttpClient httpClient;
  final String url;

  LoadRemoteYahooChart({
    required this.httpClient,
    required this.url,
  });

  @override
  AsyncResult<YahooChartEntity, FailureException> fetch(String symbol, {required LoadYahooChartParams params}) async {
    final response = await httpClient.request(
      url: "$url/$symbol",
      parameters: params.toMap(),
      method: HttpMethod.GET,
    );

    return response.fold((success) => Success(YahooChartModelRemote.fromJson(success["chart"]).toEntity()), (failure) {
      if (failure is InternetNotFoundRequestException) {
        return Failure(
          FailureException(
            message: failure.message,
            code: failure.code,
          ),
        );
      } else if (failure is BadRequestException) {
        return Failure(
          FailureException(
            message: failure.message,
            code: failure.code,
            errors: failure.errors,
          ),
        );
      }

      return Failure(
        FailureException(
          message: failure.message,
          code: failure.code,
        ),
      );
    });
  }
}
