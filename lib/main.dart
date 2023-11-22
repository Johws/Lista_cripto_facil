import 'package:flutter/material.dart';
import 'package:lista_cripto_facil/controller/coinController.dart';
import 'package:lista_cripto_facil/view/CoinListView.dart'; // Confirme se está importando a classe correta
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
        home:
            CoinListView(), // Certifique-se de estar chamando a classe correta
      ),
    );
  }
}
