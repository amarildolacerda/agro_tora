
// activity_model.dart
class Activity {
  final String titulo;
  final String descricao;

  Activity({
    required this.titulo,
    required this.descricao,
  });

  factory Activity.fromMap(Map<String, dynamic> data) {
    return Activity(
      titulo: data['titulo'],
      descricao: data['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
    };
  }
}