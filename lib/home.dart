import 'package:flutter/material.dart';
import 'package:task_1/views/dashbordPage.dart';
import 'package:task_1/views/ordersPage.dart';
import 'package:task_1/views/state/manager.dart';

class MyHomePage extends StatefulWidget {
  final OrderManager orderManager;
  const MyHomePage({required this.orderManager, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Text("Ahwa Manager", style: TextStyle(color: Colors.white)),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.request_page_outlined), text: "Orders"),
              Tab(icon: Icon(Icons.dashboard_outlined), text: "Dash"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrdersPage(orderManager: widget.orderManager),
            DashboardPage(orderManager: widget.orderManager),
          ],
        ),
      ),
    );
  }
}
