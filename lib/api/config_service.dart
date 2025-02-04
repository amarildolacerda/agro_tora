// baseUrl: https://us-central1-selfandpay.cloudfunctions.net/v3
// endpoint: dpl

// criar classe factory static para configurar a API

import 'package:controls_data/data.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static final Config _singleton = Config._internal();
  Config._internal();

  ODataInst get api => ODataInst();

  init({required String baseUrl, bool dbgMode = false}) {
    accountId = 'dpl';
    api.baseUrl = baseUrl;
    checkLembrar();

    api.client.inDebug = dbgMode;
    if (dbgMode) {
      api.client.notify.stream.listen((event) {
        // ignore: avoid_print
        print('notify: $event');
      });
      api.client.inDebug = true;
      api.client.notifyLog.stream.listen((event) {
        // ignore: avoid_print
        print('notifyLog: $event');
      });
      api.client.notifyError.stream.listen((event) {
        // ignore: avoid_print
        print('notifyError: $event');
      });
    }
  }

  factory Config() => _singleton;

  get baseUrl => api.baseUrl;
  set baseUrl(x) => api.baseUrl = x;
  get apiKey => api.client.authorization;
  set apiKey(x) => api.client.authorization = x;

  String? token;
  String _accountId = "dpl";
  String get accountId => _accountId;
  set accountId(String x) {
    _accountId = x;
    api.client.addHeader('contaid', accountId);
  }

/*Future<Map<String,dynamic>>getRows({
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
*/
  final UserModel user = UserModel();
  final ValueNotifier<bool> logadoEvent = ValueNotifier(false);

  login(String usuario, String senha) {
    return api.loginBasic(accountId, usuario, senha).then((r) {
      apiKey = api.client.authorization;
      user.usuario = usuario;
      user.senha = senha;
      logadoEvent.value = true;
      return r;
    });
  }

  bool get logado => false;
  set logado(bool x) {
    logadoEvent.value = x;
  }

  bool lembrarUltimoLogin = false;
  Future<bool> checkLembrar() async {
    final prefs = await SharedPreferences.getInstance();
    lembrarUltimoLogin = prefs.getBool('lembrar') ?? false;
    if (lembrarUltimoLogin) {
      user.usuario = prefs.getString('usuario') ?? '';
      user.senha = prefs.getString('senha') ?? '';
      token = prefs.getString('token') ?? '';
      logado = true;
      apiKey = token;
      api.client.tokenId = token;
      api.client.authorization = 'Bearer $token';
      return lembrarUltimoLogin;
    }
    return false;
  }

  // Método para limpar os dados do último login
  void limparLembrar({bool tudo = false}) async {
    lembrarUltimoLogin = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lembrar', false);
    await prefs.remove('senha');
    if (tudo) {
      await prefs.remove('usuario');
    }
  }

  void logout() {
    limparLembrar();
    logado = false;
  }

  void lembrar(bool aplica) async {
    lembrarUltimoLogin = aplica;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lembrar', lembrarUltimoLogin);
    if (lembrarUltimoLogin) {
      await prefs.setString('usuario', user.usuario!);
      await prefs.setString('password', user.senha!);
      await prefs.setString('token', token!);
    } else {
      limparLembrar();
    }
  }
}
