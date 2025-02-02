import 'package:controls_data/data.dart';
import 'package:tora/api/guid.dart';

class AreaModel {
   String? id; // ID único da área
   String identificacao; // Identificação única da área (ex: código)
   String nome; // Nome da área
   double tamanho; // Tamanho da área em hectares
   Localizacao localizacao; // Localização da área (latitude e longitude)

  // adicionar estado tipo string A-Aberta F-Fechada X-Excluida S-Suspensa
   String estado;

  AreaModel({
    required this.identificacao,
    required this.nome,
    required this.tamanho,
    required this.localizacao,
    required this.estado,
    this.id = '', // ID vazio por padrão (será preenchido ao salvar no Firestore)
  });

  // Converte um Map (vindo do Firestore) para um objeto AreaModel
  factory AreaModel.fromMap(Map<String, dynamic> data, String? id) {
    return AreaModel(
      id: id??data['id']??GUID.create(),
      identificacao: data['identificacao']??'',
      nome: data['nome']??'',
      tamanho: toDouble(data['tamanho']),
      estado: data['estado']??'A',
      localizacao: Localizacao.fromMap(data['localizacao']),
    );
  }

  static AreaModel createNew(){
    return AreaModel.fromMap({}, GUID.create())  ;
  }

  // Converte um objeto AreaModel para um Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'identificacao': identificacao,
      'nome': nome,
      'tamanho': tamanho,
      'estado': estado,
      'localizacao': localizacao.toMap(),
    };
  }
}

// Modelo para representar a localização (latitude e longitude)
class Localizacao {
  final double latitude;
  final double longitude;

  Localizacao({required this.latitude, required this.longitude});

  // Converte um Map (vindo do Firestore) para um objeto Localizacao
  factory Localizacao.fromMap(Map<String, dynamic>? data) {
    if (data  == null  ) {
      return Localizacao(latitude: 0,longitude: 0);
    }
    return Localizacao(
      latitude: toDouble(data['latitude']),
      longitude: toDouble(data['longitude']),
    );
  }

  // Converte um objeto Localizacao para um Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}