import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinController.dart';
import 'package:lista_cripto_facil/controller/coinEntendide.dart';
import 'package:provider/provider.dart';

class CoinListView extends StatefulWidget {
  @override
  _CoinListViewState createState() => _CoinListViewState();
}

class _CoinListViewState extends State<CoinListView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Inicia um timer que chama fetchCoinList a cada 5 segundos
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      await Provider.of<CoinController>(context, listen: false).fetchCoinList();
    });
  }

  @override
  void dispose() {
    // Cancela o timer quando o widget é descartado
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Data'),
      ),
      body: Consumer<CoinController>(
        builder: (context, coinController, child) {
          return Center(
            child: StreamBuilder<List<CoinEntidade>>(
              stream: coinController.coinListStream,
              initialData: coinController.coinList,
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
          );
        },
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
            Text('ID: ${coinData.symbol}'),
            Text('Name: ${coinData.name}'),
            Text('Price USD: ${coinData.priceUsd}'),
            Text('Volume 24h: ${coinData.volumeUsd24Hr}'),
            // Adicione mais campos conforme necessário
          ],
        ),
      ),
    );
  }
}
