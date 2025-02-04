import 'package:flutter/material.dart';
import 'package:tora/controls/masked_field.dart';
import 'package:tora/forms/area_dropfield.dart';
import '../api/data_service.dart';
import '../models/os_model.dart';

class AddOSScreen extends StatefulWidget {
  const AddOSScreen({super.key});

  @override
  _AddOSScreenState createState() => _AddOSScreenState();
}

class _AddOSScreenState extends State<AddOSScreen> {
  final _areaController = TextEditingController();
  final _firestoreService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova OS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AreaDropFormField(
              label: 'Area',
              value: '',
              onChanged: (x) {
                print(x);
              },
            ),
            TextField(
              controller: _areaController,
              decoration: InputDecoration(labelText: 'Área'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final os = OS(
                  area: _areaController.text,
                  estado: 'em_andamento',
                  atividades: [],
                );
                await _firestoreService.addOS(os);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
