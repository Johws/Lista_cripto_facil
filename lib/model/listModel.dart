import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lista_cripto_facil/controller/coinEntendide.dart';

class ListModel {
  Future<List<CoinEntidade>> fetchData() async {
    final response = await http.post(
      Uri.parse('https://api.coinext.com.br:8443/AP/GetL2Snapshot'),
      headers: {'Content-Type': 'application/json'},
      body: '{"OMSId": 1, "InstrumentId": 1, "Depth": 1}',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<CoinEntidade> coinList = jsonResponse
          .map((jsonItem) => CoinEntidade.fromJson(jsonItem))
          .toList();

      return coinList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
