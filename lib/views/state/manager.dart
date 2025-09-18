import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:task_1/models/drink.dart';
import 'package:task_1/models/order.dart';
import 'package:task_1/repo/orderRepository.dart';

class OrderManager extends ChangeNotifier {
  final IOrderRepository repository;

  final List<Order> _cache = [];

  OrderManager({required this.repository});

  UnmodifiableListView<Order> get allOrders => UnmodifiableListView(_cache);

  List<Order> get pendingOrders => _cache.where((o) => !o.completed).toList();

  void load() {
    final orders = repository.fetchAllOrders();
    _cache
      ..clear()
      ..addAll(orders);
    notifyListeners();
  }

  void addOrder({required String customerName, required Drink drink}) {
    final order = Order(
      id: UniqueKey().toString(),
      customerName: customerName,
      drink: drink,
    );
    repository.addOrder(order);
    _cache.add(order);
    notifyListeners();
  }

  void completeOrder(String id) {
    repository.completeOrder(id);
    final o = _cache.firstWhere((e) => e.id == id);
    o.markComplete();
  }

  Map<String, dynamic> generateReport() {
    final Map<String, int> counts = {};
    int served = 0;
    for (final o in _cache) {
      counts[o.drink.displayName] = (counts[o.drink.displayName] ?? 0) + 1;
      if (o.completed) served++;
    }
    final sorted = Map.fromEntries(
      counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
    return {
      'topSelling': sorted,
      'totalServed': served,
      'totalOrders': _cache.length,
    };
  }
}
