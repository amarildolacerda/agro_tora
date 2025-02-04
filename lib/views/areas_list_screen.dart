// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tora/api/data_service.dart';
import 'package:tora/api/root_service.dart';
import 'package:tora/notifiers/areas_notify.dart';
import 'package:tora/views/add_area_screen.dart';

import '../models/area_model.dart'; // Importe o modelo de área

class AreasListScreen extends StatelessWidget {
  const AreasListScreen({super.key});

  // Método para buscar a lista de áreas do Firestore
  Future<List<dynamic>> _fetchAreas() async {
    final snapshot = await API.getRows(
      resource: 'areas',
    ); // filter: "estado eq 'A'");
    return snapshot as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Áreas Cadastradas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            roots.goToHome(context);
          },
        ),
      ),
      body: ListenableBuilder(
          listenable: areaNotifyChanged,
          builder: (ctx, ch) {
            return FutureBuilder(
              future: _fetchAreas(), // Future que busca as áreas
              builder: (context, snapshot) {
                // Verifica o estado do Future
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Exibe um loading
                }

                // Verifica se ocorreu um erro
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Erro ao carregar áreas: ${snapshot.error}'));
                }

                // Verifica se há dados
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhuma área cadastrada.'));
                }

                // Exibe a lista de áreas
                final areaList = snapshot.data!;
                return ListView.builder(
                  itemCount: areaList.length,
                  itemBuilder: (context, index) {
                    final o = areaList[index];
                    final AreaModel area = AreaModel.fromMap(o, o['id']);
                    return ListTile(
                      title: Text(area.nome),
                      subtitle: Text('nome: ${area.nome}'),
                      trailing: Text('${area.tamanho} ha'),
                      onTap: () {
                        // Navega para a tela de detalhes da área (opcional)
                        // Navigator.of(context).push(...);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddAreaScreen.edit(area),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega para a tela de cadastro de área (opcional)
          // Navigator.of(context).push(...);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddAreaScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
/*
class AddAreaScreen extends StatefulWidget {
  const AddAreaScreen({super.key});

  @override
  _AddAreaScreenState createState() => _AddAreaScreenState();
}

class _AddAreaScreenState extends State<AddAreaScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para validação do formulário
  final _identificacaoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _tamanhoController = TextEditingController();
  Localizacao? _localizacao; // Localização da área
  final data = DataService();

  // Método para capturar a localização atual
  Future<void> _capturarLocalizacao() async {
    try {
      bool servicoHabilitado = await Geolocator.isLocationServiceEnabled();
      if (!servicoHabilitado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('O serviço de localização está desabilitado.')),
        );
        return;
      }

      LocationPermission permissao = await Geolocator.checkPermission();
      if (permissao == LocationPermission.denied) {
        permissao = await Geolocator.requestPermission();
        if (permissao == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Permissão de localização negada.')),
          );
          return;
        }
      }

      Position posicao = await Geolocator.getCurrentPosition();
      setState(() {
        _localizacao = Localizacao(
          latitude: posicao.latitude,
          longitude: posicao.longitude,
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao capturar localização: $e')),
      );
    }
  }

  // Método para salvar a área
  void _salvarArea() {
    if (_formKey.currentState!.validate() && _localizacao != null) {
      final area = AreaModel(
        identificacao: _identificacaoController.text,
        nome: _nomeController.text,
        tamanho: double.parse(_tamanhoController.text),
        estado: 'A',
        localizacao: _localizacao!,
      );

      // Aqui você pode salvar a área no Firestore ou em outro local
      //print('Área salva: ${area.toMap()}');

      data.addArea(area.toMap());
      // Limpar o formulário após salvar
      _formKey.currentState!.reset();
      setState(() {
        _localizacao = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Área cadastrada com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Preencha todos os campos e capture a localização.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Área'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _identificacaoController,
                decoration: InputDecoration(labelText: 'Identificação'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tamanhoController,
                decoration: InputDecoration(labelText: 'Tamanho (ha)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Digite um número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Localização:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (_localizacao != null)
                Text(
                  'Latitude: ${_localizacao!.latitude}, Longitude: ${_localizacao!.longitude}',
                  style: TextStyle(fontSize: 14),
                ),
              ElevatedButton(
                onPressed: _capturarLocalizacao,
                child: Text('Capturar Localização'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarArea,
                child: Text('Salvar Área'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/