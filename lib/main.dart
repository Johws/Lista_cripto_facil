// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinController.dart';
import 'package:lista_cripto_facil/view/coinlistView.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoinController(),
      child: MaterialApp(
        home: CoinListView(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
