import 'dart:convert';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ListModel {
  Future<List<CoinEntidade>> fetchData() async {
    final WebSocketChannel channel = WebSocketChannel.connect(
        Uri.parse('wss://api.coinext.com.br/WSGateway/'));

    final payload = {
      "OMSId": 1,
      "InstrumentId": 1,
      "Interval": 60,
    };

    final frame = {
      'm': 0,
      'i': 2,
      'n': 'SubscribeTicker',
      'o': jsonEncode(payload),
    };

    channel.sink.add(jsonEncode(frame));

    final List<CoinEntidade> coinList = [];

    channel.stream.listen(
      (dynamic message) {
        final data = jsonDecode(message)['o'];
        final coinData = CoinEntidade.fromJson(data);
        coinList.add(coinData);
      },
      onDone: () {
        channel.sink.close();
      },
      onError: (error) {
        throw Exception('WebSocket error: $error');
      },
    );
    return coinList;
  }
}
