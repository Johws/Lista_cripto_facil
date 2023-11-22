// lib/controller/coin_controller.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinController extends ChangeNotifier {
  List<CoinEntidade>? coinList;
  StreamController<List<CoinEntidade>> controller =
      StreamController<List<CoinEntidade>>();
  late WebSocketChannel _channel;

  Stream<List<CoinEntidade>> get coinListStream => controller.stream;

  CoinController() {
    connectToWebSocket();
  }

  void connectToWebSocket() {
    _channel = WebSocketChannel.connect(
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

    _channel.sink.add(jsonEncode(frame));

    _channel.stream.listen(
      (dynamic message) {
        final data = jsonDecode(message)['o'];
        final coinData = CoinEntidade.fromJson(data);
        coinList = [coinData];
        controller.add(coinList!);
      },
      onDone: () {
        _channel.sink.close();
      },
      onError: (error) {
        throw Exception('WebSocket error: $error');
      },
    );
  }

  @override
  void dispose() {
    controller.close();
    _channel.sink.close();
    super.dispose();
  }
}
