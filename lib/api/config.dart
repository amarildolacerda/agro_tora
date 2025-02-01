// baseUrl: https://us-central1-selfandpay.cloudfunctions.net/v3
// endpoint: dpl

// criar classe factory static para configurar a API

import 'package:controls_data/data.dart';



class Config {
  static final Config _singleton = Config._internal();
  Config._internal();

  get api => ODataInst();
  
  
  init({baseUrl}) {
    if (baseUrl != null) {
      api.baseUrl = baseUrl;
    }
  }
  factory Config() => _singleton;

  get baseUrl => api.baseUrl;
  set baseUrl(x) => api.baseUrl = x;
  get apiKey => api.client.authorization;
  set apiKey(x) => api.client.authorization = x;
  String accountId = "dpl";
  bool logado = false;



Future<Map<String,dynamic>>getRows({
    required String resource,
    String select = '*',
    int? top,
    int? skip,
    String? filter,
    String? groupby,
    String? join,
    String? orderby,
    String? cacheControl,
  }) async {
    return send(
      ODataQuery(
        resource: resource,
        select: select,
        filter: filter,
        top: top,
        skip: skip,
        groupby: groupby,
        join: join,
        orderby: orderby,
      ),
      cacheControl: cacheControl,
    ).then((rsp) {
      return rsp['result'] ?? rsp['value'];
    });
  }

Future<Map<String,dynamic>> send(ODataQuery query, {String? cacheControl}) async {
    try {
      api.client.service = query.toString();
      return api.client
          .openJsonAsync(api.client.encodeUrl(), cacheControl: cacheControl)
          .then((res) {
        return res;
      });
    } catch (e) {
      ErrorNotify.send('$e');
      rethrow;
    }
  }


}

