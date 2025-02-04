import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../api/data_service.dart';
import '../models/os_model.dart';

class AddActivityScreen extends StatefulWidget {
  final OS os;

  const AddActivityScreen({super.key, required this.os});

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _firestoreService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Atividade')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final atividade = Activity(
                  titulo: _tituloController.text,
                  descricao: _descricaoController.text,
                );
                await _firestoreService.addActivity(widget.os.id, atividade);
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