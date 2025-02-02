import 'package:flutter/material.dart';

import '../api/data_service.dart';
import '../models/area_model.dart';

class AreaDropFormField extends StatelessWidget {
  final String label;
  final String value;
  final Function(AreaModel) onChanged;

  const AreaDropFormField(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged});

  Future<List<AreaModel>> fetchItems() async {
    final response = await DataService().listAreas(true);
    if (response != null) {
      List<dynamic> data = response as List<dynamic>;
      return data.map((item) => AreaModel.fromMap(item, item['id'])).toList();
    } else {
      throw Exception('Falha ao carregar os itens');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchItems(),
        builder: (context, values) {
          if (values.hasData) {
            final List<AreaModel> areas = values.data as List<AreaModel>;
            return DropdownButtonFormField<String>(
              value: value,
              onChanged: (x) {
                final area = areas.firstWhere((element) => element.nome == x);
                onChanged(area);
              },
              items: areas.map<DropdownMenuItem<String>>((AreaModel value) {
                return DropdownMenuItem<String>(
                  value: value.nome,
                  child: Text(value.nome),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}
