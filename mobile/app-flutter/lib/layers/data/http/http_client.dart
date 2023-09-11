// ignore_for_file: constant_identifier_names

import 'package:result_dart/result_dart.dart';

import '../../../commons/commons.dart';

extension HttpMethodExtension on HttpMethod {
  String get description {
    switch (this) {
      case HttpMethod.GET:
        return 'GET';
      case HttpMethod.HEAD:
        return 'HEAD';
      case HttpMethod.POST:
        return 'POST';
      case HttpMethod.PUT:
        return 'PUT';
      case HttpMethod.DELETE:
        return 'DELETE';
      case HttpMethod.PATCH:
        return 'PATCH';
      default:
        return 'DOWNLOAD';
    }
  }
}

enum HttpMethod {
  ///
  /// The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.
  /// O método GET solicita uma representação do recurso especificado. As solicitações que usam GET devem apenas recuperar dados.
  ///
  GET,

  ///
  /// The HEAD method asks for a response identical to a GET request, but without the response body.
  /// O método HEAD solicita uma resposta idêntica a uma solicitação GET, mas sem o corpo da resposta.
  ///
  HEAD,

  ///
  /// The POST method submits an entity to the specified resource, often causing a change in state or side effects on the server.
  /// O método POST envia uma entidade para o recurso especificado, geralmente causando uma alteração no estado ou efeitos colaterais no servidor.
  ///
  POST,

  ///
  /// The PUT method replaces all current representations of the target resource with the request payload.
  /// O método PUT substitui todas as representações atuais do recurso de destino pela carga útil da solicitação.
  ///
  PUT,

  ///
  /// The DELETE method deletes the specified resource.
  /// O método DELETE exclui o recurso especificado.
  ///
  DELETE,

  ///
  /// The PATCH method applies partial modifications to a resource.
  /// O método PATCH aplica modificações parciais a um recurso.
  ///
  PATCH
}

abstract class HttpClient {
  Future<Result<dynamic, ServerException>> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? parameters,
  });
}
