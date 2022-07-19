import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_listas/modelo/TemperaturaModel.dart';

import '../helper/API.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

import '../modelo/DTemperatura.dart';

class DTemperaturaProvider extends ChangeNotifier {
  API service = API();
  List<DTemperaturaModel> listDTemperaturas = [];

  DTemperaturaProvider() {
    print('DTemperaturaProvider inicializado');
    getDTemperaturas();
  }

  getDTemperaturas() async {
    var uri = Uri.parse(
      '${service.urlBase}getDispositivos',
    );

    final response = await http.get(uri);
    final responseJson = response.body;
    final Distemperaturas =
        DTemperaturas.fromJsonList(json.decode(responseJson));

    listDTemperaturas = Distemperaturas.items;
    notifyListeners();
  }

  Future<List<DTemperaturaModel>> getUltimasTemeperaturas(
      {required idDispositivo}) async {
    DateTime now = DateTime.now();
    var uri = Uri.parse(
      '${service.urlBase}support/ultimasTemperaturas?id=$idDispositivo&${now.toString()}',
    );

    final response = await http.get(uri);
    final responseJson = service.getResponse(response.body);
    final responseTemperaturas = DTemperaturas.fromJsonList(responseJson);
    print(responseTemperaturas.items);
    return responseTemperaturas.items;
  }
}