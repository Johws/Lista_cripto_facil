import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinController.dart';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:provider/provider.dart';

class CoinListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Data'),
      ),
      body: Consumer<CoinController>(
        builder: (context, coinController, child) {
          return Center(
            child: coinController.coinList != null
                ? CoinList(cards: coinController.coinList!)
                : CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CoinController>(context, listen: false).fetchCoinList();
        },
        child: Icon(Icons.refresh),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${coinData.id}'),
            Text('Type: ${coinData.type}'),
            // Adicione mais campos conforme necessário
          ],
        ),
      ),
    );
  }
}
