
import 'package:controls_web/controls.dart';
import 'package:controls_web/controls/data_viewer.dart';
import 'package:flutter/material.dart';

import '../api/dados.dart';

class ListaAreas extends StatelessWidget {
  const ListaAreas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Áreas'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro_area');
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
            future: API.getRows(resource: 'areas'),
            builder: (a, b) {
              if (!b.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List<dynamic> dados = b.data as List<dynamic>;
              dados.sort((a, b) => a['nome'].compareTo(b['nome']));

              if (dados.isEmpty) {
                return Center(
                  child: Text('Nenhum registro encontrado'),
                );
              }
              return DataViewer(
                source: dados,
                columns: [
                  PaginatedGridColumn( label: 'Nome'),
                ],
              );
             /* return ListView.builder(
                  itemCount: dados.length,
                  itemBuilder: (context, index) {
                    final ha = dados[index]["tamanho"].toString();
                    return ListTile(
                      title: Text(dados[index]['nome']),
                      subtitle: Text('$ha ha'),
                    );
                  });
              */
            }));
  }
}

