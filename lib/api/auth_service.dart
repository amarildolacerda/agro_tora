import 'package:flutter/foundation.dart';

import 'config_service.dart';
import 'data_service.dart';

class AuthService {
  Future<bool> login(String usuario, String password) async {
    // Simulate a network request
    final tk = await API.loginBasic(Config().accountId, usuario, password);
    if (kDebugMode) {
      print('login: $tk');
    }
    if (tk == null) {
      return false;
    }
    Config()
      ..logado = true
      ..token = tk
      ..apiKey = API.client.authorization
      ..user.usuario = usuario
      ..user.senha = password;
    return true;
  }

  void lembrar(bool aplica) {
     Config().lembrar(aplica);
  }
}
