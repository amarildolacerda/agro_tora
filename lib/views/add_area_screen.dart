import 'package:controls_data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tora/models/area_model.dart';
import 'package:tora/notifiers/areas_notify.dart';

// ignore: must_be_immutable
class AddAreaScreen extends StatelessWidget {
  AddAreaScreen({super.key, AreaModel? area, this.editing = false}) {
    if (area != null) {
      this.area = AreaModel.fromMap(area.toMap(), area.id);
      initalId = area.id;
    }
  }
  AreaModel? area = AreaModel.createNew();
  String? initalId ;
  bool editing = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Área Rural'),
        actions: [
          if (editing)
          IconButton(icon:Icon(Icons.delete),  onPressed: (){
            area!.estado = 'X';
            ODataInst().post('delete/areas',  area!.toMap() ) .then((x) {
              Navigator.pop(context);
              areaNotifyChanged.notify();
            });
          })  
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: area?.id,
                decoration:
                    const InputDecoration(labelText: 'Identificador da Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o identificador da área';
                  }
                  return null;
                },
                onSaved: (value) {
                  area?.id = value!;
                },
              ),

              TextFormField(
                initialValue: area?.nome,
                decoration: const InputDecoration(labelText: 'Nome da Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da área';
                  }
                  return null;
                },
                onSaved: (value) {
                  area?.nome = value!;
                },
              ),
              TextFormField(
                initialValue: area?.tamanho.toString(),
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
                  area?.tamanho = double.parse(value!);
                },
              ),
//lo
              // adicionar campo para pegar a localização da area
              TextFormField(
                initialValue: area?.localizacao.toString(),
                decoration:
                    const InputDecoration(labelText: 'Localização da Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a localização da área';
                  }
                  return null;
                },
                onSaved: (value) {
                  //area?.local = value!;
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
                          content:
                              Text('Área ($nome) cadastrada com sucesso!')),
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

  get nome => area?.nome;
  void gravar(context) {
    try {
      if (editing) {
        ODataInst().put('areas', area!.toMap()
        ).then((x) {
          Navigator.pop(context);
          areaNotifyChanged.notify();
        });
        return;
      }
      ODataInst().post('areas', area!.toMap()
      ).then((x) {

        Navigator.pop(context);
        areaNotifyChanged.notify();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static edit(AreaModel area) {
    return AddAreaScreen(area: area, editing: true);
  }
}
