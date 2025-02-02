// os_model.dart
import 'activity_model.dart';
class OS {
  final String id;
  final String area;
  final String estado;
  final List<Activity> atividades;

  OS({
    required this.area,
    required this.estado,

    required this.atividades,
    this.id = '',
  });

  factory OS.fromMap(Map<String, dynamic> data, String id) {
    return OS(
      id: id,
      area: data['area'],
      estado: data['estado'],
      atividades: (data['atividades'] as List).map((a) => Activity.fromMap(a)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'area': area,
      'estado': estado,
      'atividades': atividades.map((a) => a.toMap()).toList(),
    };
  }
}
