import 'package:flutter/material.dart';
import 'package:tora/api/config_service.dart';
import 'package:tora/views/os_list_screen.dart';
import 'views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Config cfg = Config();

  @override
  void initState() {
    super.initState();
    _initializeConfig();
  }

  Future<void> _initializeConfig() async {
    try {
      await cfg.init(baseUrl: 'https://us-central1-selfandpay.cloudfunctions.net/v3/');
    } catch (e) {
      // Handle initialization errors here
      // ignore: avoid_print
      print('Failed to initialize config: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Florestal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValueListenableBuilder<bool>(
        valueListenable: cfg.logadoEvent,
        builder: (BuildContext context, bool isLoggedIn, Widget? child) {
          return isLoggedIn ? OSListScreen() : LoginScreen();
        },
      ),
    );
  }
}
