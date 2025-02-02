import 'package:controls_data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tora/api/config_service.dart';
import 'package:tora/view/os_list_screen.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Config cfg = Config();

  @override
  Widget build(BuildContext context) {
    cfg.init(baseUrl: 'https://us-central1-selfandpay.cloudfunctions.net/v3/');

    RestClient cli = cfg.api.client;
    cli.inDebug = kDebugMode;
    cli.notify.stream.listen((event) {
      if (kDebugMode) {
        print('notify: $event');
      }
    });
    cli.inDebug = true;
    cli.notifyLog.stream.listen((event) {
      if (kDebugMode) {
        print(cli.authorization);
        print('notifyLog: $event');
      }
    });
    cli.notifyError.stream.listen((event) {
      if (kDebugMode) {
        print('notifyError: $event');
      }
    });

    return MaterialApp(
        title: 'Gestão de OS',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ValueListenableBuilder(
            valueListenable: cfg.logadoEvent,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return value ? OSListScreen() : LoginScreen();
            }));
  }
}
