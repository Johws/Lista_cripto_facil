import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:lista_cripto_facil/model/listModel.dart';

class CoinController extends ChangeNotifier {
  List<CoinEntidade>? coinList;
  StreamController<List<CoinEntidade>> controller =
      StreamController<List<CoinEntidade>>();

  Stream<List<CoinEntidade>> get coinListStream => controller.stream;

  final ListModel _model = ListModel();

  Future<void> fetchCoinList() async {
    try {
      var fetchedCoinList = await _model.fetchData();
      coinList = fetchedCoinList; // Atualiza a variável local
      controller.add(coinList!); // Adiciona a lista ao Stream
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    controller.close(); // Fecha o StreamController
    super.dispose();
  }
}
