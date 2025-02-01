// criar a lista de opções de navegação
import 'package:tora/view/cadastro_area.dart';
import 'lista_areas.dart';
routes() {
  return {
    '/cadastro_area': (context) => const CadastroAreaPage(),
    '/lista_areas': (context) => const ListaAreas()
  };
}
