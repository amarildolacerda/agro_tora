import 'package:flutter/material.dart';

import '../view/areas_list_screen.dart';

class Roots {
  final area = 'area';
  final os = 'os';
  final atividades = 'atividades';
  final usuario = 'usuario';

  void goToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void goAreaList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AreasListScreen()),
    );
  }
}

Roots get roots => Roots();
