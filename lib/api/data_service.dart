import 'package:controls_data/data.dart';
import 'package:tora/models/activity_model.dart';
import 'package:tora/models/os_model.dart';

class DataService {
  Future< dynamic > getOSListEmAndamento() {
    return API.getRows(resource: 'os',filter: "estado eq 'A'");
  }

  addOS(OS os) {}

  addActivity(String id, Activity atividade) {}

  void addArea(Map<String, dynamic> map) {
    API.post('areas', map);
  }
  listAreas(bool abertas){
    String q = (abertas)?"A":"F";
    return API.getRows(resource: 'areas', filter:  "estado eq '$q'", );
  }
}

ODataInst get API {
  return ODataInst();
}
