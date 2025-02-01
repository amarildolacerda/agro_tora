import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // criar opção de navegação para a pagina de cadastro de áreas
    // criar opção de navegação para a pagina de listagem de áreas
    // criar opção de navegação para a pagina de cadastro de culturas
    // criar opção de navegação para a pagina de listagem de culturas
    // criar opção de navegação para a pagina de cadastro de operações
    // criar opção de navegação para a pagina de listagem de operações
    // criar opção de navegação para a pagina de cadastro de funcionários
    // criar opção de navegação para a pagina de listagem de funcionários
    // criar opção de navegação para a pagina de cadastro de equipamentos
    // criar opção de navegação para a pagina de listagem de equipamentos
    // criar opção de navegação para a pagina de cadastro de safra
    // criar opção de navegação para a pagina de listagem de safras
    // criar opção de navegação para a pagina de cadastro de colheita
    // criar opção de navegação para a pagina de listagem de colheita
    // criar opção de navegação para a pagina de cadastro de vendas
    // criar opção de navegação para a pagina de listagem de vendas
    // retornar um lista de menus para o drawer mostrar as opções de navegação
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Menu'),
      ),
      ListTile(
        title: const Text('Áreas'),
        onTap: () {
          Navigator.pushNamed(context, '/lista_areas');
        },
      ),
      /*ListTile(
        title: const Text('Listagem de Áreas'),
        onTap: () {
          Navigator.pushNamed(context, '/listagem_areas');
        },
      ),
      ListTile(
        title: const Text('Cadastro de Culturas'),
        onTap: () {
          Navigator.pushNamed(context, '/cadastro_cultura');
        },
      ),
      ListTile(
        title: const Text('Listagem de Culturas'),
        onTap: () {
          Navigator.pushNamed(context, '/listagem_culturas');
        },
      ),
      ListTile(
        title: const Text('Cadastro de Operações'),
        onTap: () {
          Navigator.pushNamed(context, '/cadastro_operacao');
        },
      ),
      ListTile(
        title: const Text('Listagem de Operações'),
        onTap: () {
          Navigator.pushNamed(context, '/listagem_operacoes');
        },
      ),
      ListTile(
        title: const Text('Cadastro de Funcionários'),
        onTap: () {
          Navigator.pushNamed(context, '/cadastro_funcionario');
        },
      ),
      ListTile(
        title: const Text('Listagem de Funcionários'),
        onTap: () {
          Navigator.pushNamed(context, '/listagem_funcionarios');
        },
      ),
      ListTile(
        title: const Text('Cadastro de Equipamentos'),
        onTap: () {
          Navigator.pushNamed(context, '/cadastro_equipamento');
        },
      ),
      ListTile(
        title: const Text('Listagem de Equipamentos'),
        onTap: () {
          Navigator.pushNamed(context, '/listagem_equipamentos');
        },
      ),
      ListTile(
        title: const Text('Cadastro de Safra'),
        onTap: () {
          Navigator.pushNamed(context, '/cadastro_safra');
        },
      ),
      ListTile(
        title: const Text('Listagem de Safras'),
        onTap: () {
          Navigator.pushNamed(context, '/listagem_safras');
        },
      ),
      const ListTile(title: Text('Cadastro'))
   */ ]));
  }
}
