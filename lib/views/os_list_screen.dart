import 'package:flutter/material.dart';
import 'package:tora/views/menu_drawer.dart';
import '../api/data_service.dart';
import 'os_detail_screen.dart';
import 'add_os_screen.dart';

class OSListScreen extends StatelessWidget {
  final DataService data = DataService();

  OSListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ordens de Serviço')),
      drawer: MenuDrawer(),
      body: FutureBuilder(
        future: data.getOSListEmAndamento(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData ) {
            return Center(child: Text('Nenhuma OS encontrada.'));
          }
          //final osList = snapshot.data!;
          final List<dynamic> osList = snapshot.data as List<dynamic>;
          osList.sort((a, b) => a['nome'].compareTo(b['nome']));

          return ListView.builder(
            itemCount: osList.length,
            itemBuilder: (context, index) {
              final os = osList[index];
              return ListTile(
                title: Text(os.area),
                subtitle: Text('Status: ${os.estado}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => OSDetailScreen(os: os),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddOSScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
