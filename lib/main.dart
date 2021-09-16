// @dart=2.9
import 'package:flutter/material.dart';
import 'package:mardegrau/Providers/product_provider.dart';
import 'package:mardegrau/screens/Admin.dart';
import 'package:mardegrau/screens/MisPedidos.dart';
import 'package:mardegrau/screens/inicio.dart';
import 'package:provider/provider.dart';
import 'Providers/cart_provider.dart';
import 'Providers/tables_provider.dart';

void main() {
  // setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider.value(value: TablesProvider.init()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/NuestraCarta',
      title: 'Mar de Grau',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/NuestraCarta': (context) => inicio(),
        '/MisPedidos': (context) => MisPedidos(),
        '/admin': (context) => adminHome(),
      },
      // home: inicio(),
      // home: MisPedidos(),
    );
  }
}
