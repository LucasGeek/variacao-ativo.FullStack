import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../commons/commons.dart';
import '../../../infra/infra.dart';

HttpAdapter makeHttpAdapter() => HttpAdapter(makeHttpBase());

Dio makeHttpBase() {
  var dio = Dio(BaseOptions(
    baseUrl: NetworkBaseConfig().config.apiHostRest,
  ));

  dio.interceptors.addIf(
    kDebugMode,
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  );

  return dio;
}
