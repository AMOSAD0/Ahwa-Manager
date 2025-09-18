import 'package:flutter/material.dart';
import 'package:task_1/home.dart';
import 'package:task_1/data/order.dart';
import 'package:task_1/views/state/manager.dart';

void main() {
  final repository = DataOrder();
  final manager = OrderManager(repository: repository);
  runApp(MyApp(orderManager: manager));
}

class MyApp extends StatelessWidget {
  final OrderManager orderManager;
  const MyApp({required this.orderManager, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahwa Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: MyHomePage(orderManager: orderManager),
    );
  }
}
