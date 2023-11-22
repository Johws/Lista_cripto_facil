// lib/view/coin_list_view.dart
import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinController.dart';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:provider/provider.dart';

class CoinListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coinController = Provider.of<CoinController>(context);
    coinController.connectToWebSocket(); // Chama a conexão ao iniciar o widget

    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Data'),
      ),
      body: Center(
        child: StreamBuilder<List<CoinEntidade>>(
          stream: coinController.coinListStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data available');
            } else {
              return CoinList(cards: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class CoinList extends StatelessWidget {
  final List<CoinEntidade> cards;

  CoinList({required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CoinCard(coinData: cards[index]);
      },
    );
  }
}

class CoinCard extends StatelessWidget {
  final CoinEntidade coinData;

  CoinCard({required this.coinData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${coinData.symbol}'),
            Text('Name: ${coinData.name}'),
            Text('Price USD: ${coinData.priceUsd}'),
            // Adicione mais campos conforme necessário
          ],
        ),
      ),
    );
  }
}
