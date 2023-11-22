import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:lista_cripto_facil/model/listModel.dart';

class CoinController extends ChangeNotifier {
  List<CoinEntidade>? _coinList;

  List<CoinEntidade>? get coinList => _coinList;

  final ListModel _model = ListModel();

  Future<void> fetchCoinList() async {
    try {
      final coinList = await _model.fetchData();
      _coinList = coinList;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
