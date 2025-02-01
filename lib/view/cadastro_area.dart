import 'package:controls_data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../api/config.dart';

class CadastroAreaPage extends StatefulWidget {
  const CadastroAreaPage({super.key});

  @override
  _CadastroAreaPageState createState() => _CadastroAreaPageState();
}

class _CadastroAreaPageState extends State<CadastroAreaPage> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  double _tamanho = 0.0;
  String _id = '';
  String _local = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Área Rural'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Identificador da Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o identificador da área';
                  }
                  return null;
                },
                onSaved: (value) {
                  _id = value!;
                },
              ),  

              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome da Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da área';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Tamanho da Área (ha)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o tamanho da área';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tamanho = double.parse(value!);
                },
              ),
//lo 
              // adicionar campo para pegar a localização da area
    TextFormField(
                decoration: const InputDecoration(labelText: 'Localização da Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a localização da área';
                  }
                  return null;
                },
                onSaved: (value) {
                  _local = value!;
                },
              ),  
              // adicionar campo para pegar a data de plantio da area
    
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Processar os dados salvos (_nome e _tamanho)
                    // enviar dado para metodo grava passando _nome e _tamanho
                    gravar(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Área $_nome cadastrada com sucesso!')),
                    );
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void gravar(context) {
    try {
      ODataInst(). post( 'areas', {'id':_id,'nome': _nome, 'tamanho': _tamanho, "local":_local }).then((x){
        Navigator.pop(context);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
