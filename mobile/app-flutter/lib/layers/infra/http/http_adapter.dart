import 'dart:async';

import 'package:result_dart/result_dart.dart';

import '../../../commons/commons.dart';
import '../../data/http/http.dart';

import 'package:dio/dio.dart';

class HttpAdapter implements HttpClient {
  final Dio client;

  HttpAdapter(this.client);

  @override
  Future<Result<dynamic, ServerException>> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? parameters,
  }) async {
    var response = Response(
      requestOptions: RequestOptions(),
      statusCode: 500,
    );

    Future<Response>? futureResponse;
    try {
      futureResponse = client.fetch(
        RequestOptions(
          path: "${client.options.baseUrl}/$url",
          method: method.description,
          headers: headers,
          queryParameters: parameters,
        ),
      );

      response = await futureResponse.timeout(const Duration(seconds: 30));
    } on TimeoutException catch (error) {
      return Failure(TimeoutRequestException(error.toString()));
    } on DioError catch (error) {
      int statusCode = error.response?.statusCode ?? 500;

      if (statusCode >= 400 && statusCode < 500) {
        if (statusCode == 401) {
          return const Failure(UnauthorizedRequestException());
        } else if (statusCode == 403) {
          return const Failure(ForbiddenRequestException());
        } else if (statusCode == 404) {
          return const Failure(NotFoundRequestException());
        }

        return Failure(BadRequestException.fromJson(response.data));
      } else {
        return Failure(OtherRequestException(statusCode, error.toString()));
      }
    } catch (error) {
      return Failure(OtherRequestException(response.statusCode ?? 500, error.toString()));
    }

    return Success(response.data);
  }
}
