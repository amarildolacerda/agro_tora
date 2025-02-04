import 'package:flutter/material.dart';
import '../models/os_model.dart';
import 'add_activity_screen.dart';

class OSDetailScreen extends StatelessWidget {
  final OS os;

  const OSDetailScreen({super.key, required this.os});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da OS')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Área: ${os.area}'),
            Text('Status: ${os.estado}'),
            SizedBox(height: 20),
            Text('Atividades:'),
            Expanded(
              child: ListView.builder(
                itemCount: os.atividades.length,
                itemBuilder: (context, index) {
                  final atividade = os.atividades[index];
                  return ListTile(
                    title: Text(atividade.titulo),
                    subtitle: Text(atividade.descricao),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddActivityScreen(os: os),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}